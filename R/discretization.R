#' Produce set of intervals.
#'
#' @export
#' @param dataset training set to be discretized
#' @param method character string specifing the method to use.
#'               Choices are "id3".
#' @return A list with the members: \code{dataset} with the discretized dataset
#'         and \code{intervals} that is a list with members named with genes
#'         names and each containing a list with the intervals used for
#'         discretize that gene.
gdiscretize <- function(dataset, method = "id3"){
    switch(method,
           id3 = gdiscretize.id3(dataset),
           stop("unsupported method"))
}
