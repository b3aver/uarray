#' Produce set of intervals.
#'
#' @export
#' @param dataset training set to be discretized
#' @param method character string specifing the method to use.
#'               Choices are "id3".
#' @return discretized dataset
gdiscretize <- function(dataset, method = "id3"){
    switch(method,
           id3 = gdiscretize.id3(dataset),
           stop("unsupported method"))
}


#' Produce set of intervals.
#'
#' @references J.R. Quinlan. Induction of Decision Trees. Machine Learning  1 (1986) 81-106.
#'
#' @param dataset training set to be discretized
#' @return discretized dataset
gdiscretize.id3 <- function(dataset) {
    ## class values
    classes <- as.vector(t(dataset$class))
    ## genes names
    cols <- colnames(dataset)
    genes <- cols[which(cols!="class")]
    ## for each gene discretize its expression data
    for(gene in genes){
        attribute <- as.vector(t(dataset[gene]))
        discretized <- id3.discretize(attribute, classes)
        dataset[gene] <- discretized
    }
    dataset
}
