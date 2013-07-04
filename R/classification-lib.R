#' Apply a function on the items.
#'
#' @param model list with a member for each class, named using the class name
#'              and containing a list with the itemsets of the left-hand-side
#'              of the association rules. An itemset is a list of items.
#' @param fun function that takes an item and other arguments and return the
#'            item modified.
#' @param ... any other argument to be passed to \code{fun}
#' @return The given model with every item substituted with the result of fun
#'         applied to the item.
apply.on.items <- function(model, fun, ...){
    lapply(model,
           function(itemsets){
               lapply(itemsets,
                      function(itemset){
                          lapply(itemset,
                                 function(item){
                                     fun(item, ...)
                                 })
                      })
           })
}


#' Given an item make explicit the discretized interval.
#'
#' @param item list containing the entries: "gene" with the name of the gene and
#'          "value" for the discretized value.
#' @param intervals list with members named with genes' names and each
#'          containing a list with the intervals used for discretize that gene.
#' @return Modified item, that is  a list containing the entries: "gene" with
#'         the name of the gene, "lower" and "upper" for the bounds of the
#'         interval.
undiscretize.item <- function(item, intervals){
    ## create the list with the intervals
    list(gene = item$gene, lower = intervals[[item$gene]][[item$value]][1],
         upper = intervals[[item$gene]][[item$value]][2])
}


#' Evaluate the scoring function.
#'
#' @param sample list with the expression data for each gene in the microarray
#'               to classify.
#'               The entries of the list are named using the genes' names.
#' @param rule list with the left-hand-side itemset, where every item is
#'             represented with a list containing the entries: "gene" with the
#'             name of the gene, "lower" and "upper" for the bounds of the
#'             interval.
#' @return The value of the scoring function.
score <- function(sample, rule){
    intersection <- 0
    for(item in rule){
        if(sample[item$gene] >= item$lower && sample[item$gene] < item$upper){
            intersection <- intersection + 1
        }
    }
    intersection / length(rule) * log(length(rule))
}


#' Remove the rules with low confidence
#'
#' The given \code{rules} are filtered using the confidence measure.
#'
#' @param model list with a member for each class, named using the class name
#'         and containing a list with the itemsets of the left-hand-side of the
#'         association rules.
#'         An itemset is a list of items, where each of them is represented with
#'         a list containing the entries: "gene" with the name of the gene and
#'         "value" for the discretized value.
#' @param dataset training set with the values discretized.
#' @param confidence a numeric value for the minimal confidence of a rule.
#'          The default is 0.8.
#' @return This function returnes only the rules that have a confidence higher
#'         than the given minimum confidence: \code{confidence}.
filter.rules <- function(model, dataset, confidence = 0.8){
    model.f <- list()
    for(cl in names(model)){
        rules <- model[[cl]]
        dataset.cl <- dataset[dataset["class"]==cl,]
        for(rule in rules){
            supp.xy <- supp(rule, dataset.cl)
            supp.x <- supp(rule, dataset)
            if(supp.xy/supp.x >= confidence){
                if(is.null(model.f[[cl]])){
                    model.f[[cl]] <- list(rule)
                } else {
                    model.f[[cl]] <- c(model.f[[cl]], list(rule))
                }
            }
        }
    }
    model.f
}


#' Compute the absolute support of an itemset.
#'
#' Note that this function computes the absolute support and not the relative.
#'
#' @param itemset list of items, where each of them is represented with a list
#'          containing the entries: "gene" with the name of the gene and "value"
#'          for the discretized value.
#' @param dataset dataset with the values discretized.
#' @return Absolute support of the itemset for the given dataset.
supp <- function(itemset, dataset){
    satisfied <- apply(dataset, 1,
                       function(sample){
                           for(item in itemset){
                               if(sample[item$gene] != item$value){
                                   return(FALSE)
                               }
                           }
                           TRUE
                       })
    sum(satisfied)
}
