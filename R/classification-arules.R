#' Association rules classification using the arules package.
#'
#' @encoding utf8
#' @references
#' Michael Hahsler, Christian Buchta, Bettina Grün and Kurt Hornik.
#' Introduction to arules – A computational environment for mining association
#' rules and frequent item sets
#'
#' @name classification-arules
NULL


#' Generate the maximal frequent itemsets using the arules package.
#'
#' @seealso \code{\link[=apriori]{apriori}}
#'
#' @param dataset training set with the values discretized.
#' @param support a numeric value for the minimal support of an itemset.
#'          The default is 0.1 as in arules.
#' @return Maximal frequent itemsets.
#'         List with a member for each class, named using the class name and
#'         containing a list with the itemsets of the left-hand-side of the
#'         association rules.
#'         An itemset is a list of items, where each of them is represented with
#'         a list containing the entries: "gene" with the name of the gene and
#'         "value" for the discretized value.
mfi.arules <- function(dataset, support = 0.1){
    ## retrieve the classes
    classes <- unique(as.vector(t(dataset["class"])))
    ## transform the dataset's columns from vectors to factors
    dataset[,colnames(dataset)] <-
        lapply(dataset[,colnames(dataset)] , factor)

    mfi <- list()
    ## for each class compute the maximal frequent itemsets
    for(cl in classes){
        ## take only the samples with class cl
        trainingset <- dataset[dataset["class"]==cl,]
        ## remove the class columns
        trainingset <- trainingset[-1]
        ## create the transactions
        transactions <- as(trainingset, "transactions")
        ## execute the apriori algorithm
        parameters <- list(target="maximally frequent itemsets", maxlen=10,
                           support=support)
        control <- list(verbose=F)
        itemsets <- apriori(transactions, parameter=parameters, control=control)
        ## extract only the items from the result
        itemsets <- as(items(itemsets), "list")

        ## attach the itemsets to the model to return
        mfi[[as.character(cl)]] <- itemsets
    }

    apply.on.items(mfi, parse.item)
}


#' Given an item returned from arules make explicit the discretized interval.
#'
#' @param item string in the form <gene name>=<discretized value>.
#' @return Modified item, that is a list containing the entries: "gene" with the
#'         name of the gene and "value" for the discretized value.
parse.item <- function(item){
    ## split the item in gene name and value
    split.point <- regexpr("=[0-9]*$", item)
    split.point <- split.point[1]
    gene.name <- substr(item, 1, split.point - 1)
    gene.value <- as.numeric(substr(item, split.point + 1, nchar(item)))
    ## generate the parsed item
    list(gene = gene.name, value = gene.value)
}
