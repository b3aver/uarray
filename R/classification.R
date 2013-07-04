#' Train a model for the classification using the association rules.
#'
#' This function generate association rules for each class in the training set.
#' An association rule has in the right-hand-side one class and in the
#' left-hand-side a maximal frequent itemset, this is computed using the subset
#' of the training set with only the entries with the class in the
#' right-hand-side of the association rule.
#'
#' @export
#' @param dataset training set with the values discretized.
#' @param intervals list with members named with genes' names and each
#'          containing a list with the intervals used for discretize that gene.
#' @param method.mfi character string specifing the method to use for compute
#'          the maximal frequent itemsets.
#'          Choices are "arules".
#' @param support a numeric value for the minimal support of an itemset.
#'          The default is 0.1.
#' @param confidence a numeric value for the minimal confidence of a rule.
#'          The default is 0.8.
#' @return A model for the classification.
#'         List with a member for each class, named using the class name and
#'         containing a list with the itemsets of the left-hand-side of the
#'         association rules.
#'         An itemset is a list of items, where each of them is represented with
#'         a list containing the entries: "gene" with the name of the gene,
#'         "lower" and "upper" for the bounds of the interval.
train <- function(dataset, intervals, method.mfi = "arules", support = 0.1,
                  confidence = 0.8){
    mfi <- switch(method.mfi,
                  arules = mfi.arules(dataset, support),
                  stop("unsupported method"))
    ## remove the rules with low confidence
    model <- filter.rules(mfi, dataset, confidence)
    ## make the intervals in the itemsets explicit
    apply.on.items(model, undiscretize.item, intervals)
}


#' Classify a sample using the given model.
#'
#' The class of a sample is the class whose rules are maximally satisfied using
#' a scoring function.
#'
#' @export
#' @param sample list with the expression data for each gene in the microarray
#'               to classify.
#'               The entries of the list are named using the genes' names.
#' @param model list with a member for each class, named using the class name
#'              and containing a list with the itemsets of the left-hand-side
#'              of the association rules.
#'              An itemset is a list of items, where each of them is represented
#'              with a list containing the entries: "gene" with the name of the
#'              gene, "lower" and "upper" for the bounds of the interval.
#' @return The computed class for the given \code{sample}.
classify <- function(sample, model){
    num.satisfied <- list()
    for(cl in names(model)){
        num.satisfied[[cl]] <- 0
        rules <- model[[cl]]
        for(rule in rules){
            num.satisfied[[cl]] <- num.satisfied[[cl]] + score(sample, rule)
        }
        num.satisfied[[cl]] <- num.satisfied[[cl]] / length(rules)
    }
    names(which.max(num.satisfied))
}
