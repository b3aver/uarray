#' Discretization algorithm based on Class-Attribute Contingency Coefficient
#'
#' @encoding utf8
#' @references
#' C.J. Tsai, C.-I. Lee, W.-P. Yang.
#' A discretization algorithm based on  Class-Attribute Contingency Coefficient.
#' Information Sciences 178:3 (2008) 714-731.
#'
#' J. Alcalá-Fdez, L. Sánchez, S. García, M.J. del Jesus, S. Ventura,
#' J.M. Garrell, J. Otero, C. Romero, J. Bacardit, V.M. Rivas, J.C. Fernández,
#' F. Herrera.
#' KEEL: A Software Tool to Assess Evolutionary Algorithms to Data Mining
#' Problems.
#' Soft Computing 13:3 (2009) 307-318, doi: 10.1007/s00500-008-0323-y.
#'
#' J. Alcalá-Fdez, A. Fernandez, J. Luengo, J. Derrac, S. García, L. Sánchez,
#' F. Herrera.
#' KEEL Data-Mining Software Tool: Data Set Repository, Integration of
#' Algorithms and Experimental Analysis Framework.
#' Journal of Multiple-Valued Logic and Soft Computing 17:2-3 (2011) 255-287.
#'
#' @name cacc
NULL


#' Produce set of intervals using the CACC discretization method.
#'
#' @param dataset training set to be discretized
#' @return A list with the members: \code{dataset} with the discretized dataset
#'         and \code{intervals} that is a list with members named with genes
#'         names and each containing a list with the intervals used for
#'         discretize that gene.
gdiscretize.cacc <- function(dataset) {
    ## class values
    classes <- as.vector(t(dataset$class))
    ## genes names
    cols <- colnames(dataset)
    genes <- cols[which(cols!="class")]
    ## intervals list to return
    intervals <- list()
    ## for each gene discretize its expression data
    for(gene in genes){
        attribute <- as.vector(t(dataset[gene]))
        res <- discretize.attribute(cacc.cut.points, attribute, classes)
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
#' @param classes vector with the classes associated with the values in
#'                \code{values}.
#' @return Vector with the cut points.
cacc.cut.points <- function(values, classes){
    ## check function's parameters
    if(length(values) != length(classes))
        stop("Inconsistent size of values and classes")

    ## order the values and the relative classes
    ord <- order(values)
    values <- values[ord]
    classes <- classes[ord]

    ## Form a set of all distinct values in ascending order
    values.unique <- values[!duplicated(values)]

    ## Calculate the midpoints of all the adjacent pairs in the set
    lower <- values.unique[-length(values.unique)]
    upper <- values.unique[-1]
    cp <- (lower + upper)/2
    selected <- rep(F, length(cp))
    selected[1] <- T

    ## Set the initial discretization scheme as D: {[d0,dn]} and Globalcacc = 0
    globalcacc <- 0
    ##   For each  inner boundary which is not already in  scheme D
    ##   Add it into D;
    ##   Calculate the corresponding cacc value;
    ##   see if add the cutpoint with maximum cacc value
    ##   otherwise, finish the algorithm
    ##   return the selected cutpoints
    ## Output the Discretization scheme with k intervals for continous attribute
}


#' Compute the cacc value
#'
#' @param values vector with the continuous values to discretize in ascending
#'               order
#' @param classes vector with the classes associated with the values in
#'                \code{values}.
#' @param cut.points vector with the cut points.
#' @return CACC value for the given discretization scheme
cacc.value <- function(values, classes, cut.points){
    ## discretize the values w.r.t. cut.points
    intervals <- build.intervals(cut.points)
    dv <- discretize.values(values, intervals)

    ## number of samples
    m <- length(values)
    ## number of intervals
    n <- length(intervals)

    ## vector with the number of samples of each class
    mi <- as.vector(table(classes))
    ## vector with the number of samples of each interval
    mr <- as.vector(table(dv))

    ## vector that for each class i holds the sum on r of q_ir^2 / M_+r
    int <- mapply(function(cl){qir <- summary(factor(dv[classes==cl],
                                                     levels=1:n))
                               qir^2/mr
                           },
                  unique(classes), SIMPLIFY=FALSE)
    ## sum by class of the previous vectors
    cl <- mapply(sum, int)
    ## sum of the previous values divided by the respective M_i+
    s <- sum(cl/mi)

    ## apply the cacc formula
    y <- m * (s - 1)/log(n)
    sqrt(y/(y + m))
}
