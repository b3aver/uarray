#' Read a Tab Separated Values file
#'
#' Read a Tab Separated Values file
#'
#' Describe the format of the file
#'
#' @export
#' @rdname uarray-lib
#' @param filename filename from which read
#' @return dataframe
#' @references \url{http://en.wikipedia.org/wiki/Tab-separated_values}
read <- function(filename) {
    ## read the dataframe
    dataframe <- read.table(file=filename, header=T, sep="\t", dec=)
    ## correct the headers
    new.row.names <- as.character(dataframe[,1])
    new.row.names[1] <- "class"
    row.names(dataframe) <- new.row.names
    dataframe[1] <- NULL
    ## traspose the dataframe
    as.data.frame(t(dataframe))
}
