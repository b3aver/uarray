#' Discretize the values of an attribute.
#'
#' @param values vector with the continuous values to discretize.
#' @param classes vector with the classes associated with the values in
#'                \code{values}.
#' @param cut.points.fun function that takes \code{values} and \code{classes}
#'                      and return a vector with the cut points for those values.
#' @return A list with the members: vector \code{values} with the given values
#'         discretized and \code{intervals} that is a list with the intervals
#'         used for discretize the values.
discretize.attribute <- function(values, classes, cut.points.fun){
    ## retrieve the cut points
    cp <- cut.points.fun(values, classes)
    ## build the intervals
    intervals <- build.intervals(cp)
    ## discretize the values in the given intervals
    values.d <- discretize.values(values, intervals)
    list(values = values.d, intervals = intervals)
}


#' Build the intervals given the cut points.
#'
#' @param cut.points vector with the points where split the values range.
#' @return List with an entry for each interval. Every interval is represented
#'         by a vector with lower and upper bound.
build.intervals <- function(cut.points){
    lower <- c(-Inf, cut.points)
    upper <- c(cut.points, Inf)
    intervals <- mapply(c, lower, upper, SIMPLIFY=FALSE)
}


#' Discretize a series of values using the given intervals
#'
#' @param values vector with the continuous values to discretize.
#' @param intervals list with an entry for each interval. Every interval must be
#'                  represented by a vector with lower and upper bound.
#' @return Vector with the given values discretized.
discretize.values <- function(values, intervals){
    values.d <- vector()
    for(value in values){
        for(i in 1:length(intervals)){
            if(value < intervals[[i]][2]){
                values.d <- c(values.d, i)
                break
            }
        }
    }
    values.d
}
