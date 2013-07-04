#' Equal Width Interval Binning Discretizer
#'
#' @name ewib
NULL


#' Produce set of intervals using the EWIB discretization method.
#'
#' @param dataset training set to be discretized.
#' @param num.bin number of bins.
#' @return A list with the members: \code{dataset} with the discretized dataset
#'         and \code{intervals} that is a list with members named with genes
#'         names and each containing a list with the intervals used for
#'         discretize that gene.
gdiscretize.ewib <- function(dataset, num.bin = 10) {
    ## genes names
    cols <- colnames(dataset)
    genes <- cols[which(cols!="class")]
    ## intervals list to return
    intervals <- list()
    ## for each gene discretize its expression data
    for(gene in genes){
        attribute <- as.vector(t(dataset[gene]))
        res <- discretize.attribute(ewib.cut.points, attribute, num.bin)
        dataset[gene] <- res$values
        intervals[[gene]] <- res$intervals
    }
    list(dataset = dataset, intervals = intervals)
}


#' Compute cut points.
#'
#' Compute the cut points for the given values.
#'
#' @param values vector with the continuous values to discretize.
#' @param num.bin number of bins.
#' @return Vector with the cut points.
ewib.cut.points <- function(values, num.bin = 10){
    delta <- (max(values) - min(values)) / num.bin
    min(values) + delta * (1:(num.bin - 1))
}
