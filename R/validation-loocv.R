#' Leave-One-Out Cross Validation
#'
#' @name loocv
NULL


#' Compute the confusion matrix using the Leave-One-Out Cross Validation.
#'
#' @param dataset training set (with the values neither filtered nor
#'          discretized).
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
loocv <- function(dataset, method.filt = "limma", method.discr = "id3",
                  method.mfi = "arules", number.filt = 10, p.value = 1,
                  num.bin = 10, support = 0.1, confidence = 0.8){
    ## retrieve the number of classes
    classes <- sort(unique(as.vector(t(dataset["class"]))))
    num.classes <- length(classes)
    ## initialize an empty confusion.matrix
    confusion.matrix <- matrix(rep(0, num.classes^2), nrow=num.classes, byrow=T)
    rownames(confusion.matrix) <- classes
    colnames(confusion.matrix) <- classes

    for(row in 1:nrow(dataset)){
        ## take the row-th sample for test
        sample <- as.list(dataset[row,])
        ## remove the row-th sample from the training set
        trainingset <- dataset[-row,]

        ## create a model for the built trainingset
        trainingset <- gfilter(trainingset, method.filt, number.filt, p.value)
        discr.result <- gdiscretize(trainingset, method.discr, num.bin)
        trainingset <- discr.result$dataset
        intervals <- discr.result$intervals
        model <- train(trainingset, intervals, method.mfi, support, confidence)

        ## classify the sample
        cl.comp <- classify(sample, model)
        ## increment the confusion.matrix
        cl <- as.character(sample[["class"]])
        confusion.matrix[cl, cl.comp] <- confusion.matrix[cl, cl.comp] + 1
    }

    confusion.matrix
}
