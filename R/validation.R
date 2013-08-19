#' Validate a model computing the confusion matrix.
#'
#' @export
#' @param dataset training set (with the values neither filtered nor
#'          discretized).
#' @param method character string specifing the validation method.
#'          Choices are "loocv".
#' @param method.filt character string specifing the filtering method to use.
#'          Choices are "limma".
#' @param method.discr character string specifing the discretization method.
#'          Choices are "id3", "ewib", "cacc".
#' @param method.mfi character string specifing the method to use for compute
#'          the maximal frequent itemsets.
#'          Choices are "arules".
#' @param number.filt maximum number of genes to list in filtering.
#' @param p.value cutoff value for adjusted p-values.
#'          Only genes with lower p-values are listed.
#' @param num.bin number of bins for EWIB method.
#' @param support a numeric value for the minimal support of an itemset.
#'          The default is 0.1.
#' @param confidence a numeric value for the minimal confidence of a rule.
#'          The default is 0.8.
#' @return Confusion matrix, that is a matrix with rows for actual classes and
#'         columns for predicted class, the entry (i, j) is the number of
#'         samples of class i classified with class j.
validate <- function(dataset, method = "loocv", method.filt = "limma",
                     method.discr = "id3", method.mfi = "arules",
                     number.filt = 10, p.value = 1, num.bin = 10, support = 0.1,
                     confidence = 0.8){
    switch(method,
           loocv = loocv(dataset, method.filt, method.discr, method.mfi,
                         number.filt, p.value, num.bin, support, confidence),
           stop("unsupported method"))
}


#' Compute the accuracy of a model.
#'
#' @export
#' @param confusion.matrix a matrix with rows for actual classes and columns for
#'         predicted class, the entry (i, j) is the number of samples of class i
#'         classified with class j.
#' @return The computed accuracy of the model, that is the percentage of
#'         training samples correctly classified.
accuracy <- function(confusion.matrix){
    sum(diag(confusion.matrix)) / sum(confusion.matrix)
}
