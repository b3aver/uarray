#' ID3 Discretizer
#'
#' @encoding utf8
#' @references
#' J.R. Quinlan.
#' Induction of Decision Trees.
#' Machine Learning  1 (1986) 81-106.
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
#' @name id3
NULL


#' Produce set of intervals using the ID3 discretization method.
#'
#' @param dataset training set to be discretized
#' @return A list with the members: \code{dataset} with the discretized dataset
#'         and \code{intervals} that is a list with members named with genes
#'         names and each containing a list with the intervals used for
#'         discretize that gene.
gdiscretize.id3 <- function(dataset) {
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
        res <- discretize.attribute(id3.cut.points, attribute, classes)
        dataset[gene] <- res$values
        intervals[[gene]] <- res$intervals
    }
    list(dataset = dataset, intervals = intervals)
}


#' Compute cut points.
#'
#' Compute the cut points for the given values and classes.
#'
#' @param values vector with the continuous values to discretize.
#' @param classes vector with the classes associated with the values in
#'                \code{values}.
#' @return Vector with the cut points.
id3.cut.points <- function(values, classes){
    ## check function's parameters
    if(length(values) != length(classes))
        stop("Inconsistent size of values and classes")
    if(length(values) <= 1)
        return(vector())

    ## order the values and the relative classes
    ord <- order(values)
    values <- values[ord]
    classes <- classes[ord]

    ## calculate the entropy of the data
    ent.all <- id3.entropy(classes)

    ## compute the candidate cut points
    ## Vector with the indeces of the elements of values that are the first
    ## different value respect the preceding, except the first.
    ## For example, given the vector 1 1 2 3 3 4 returns 3 4 6.
    candidate.cp <- which(!duplicated(values))[-1]
    if(length(candidate.cp) == 0)
        return(vector())

    ## test each candidate cut points
    ## for search the one with the smallest entropy
    pos.min <- candidate.cp[1]
    ent.min <- id3.entropy.partition(classes, pos.min)
    candidate.cp <- candidate.cp[-1]
    for(cut.point in candidate.cp){
        ent <- id3.entropy.partition(classes, cut.point)
        if(ent < ent.min){
            ent.min <- ent
            pos.min <- cut.point
        }
    }

    ## check if the best cut point reduces the entropy
    if(ent.min < ent.all){
        cut.point <- (values[pos.min-1] + values[pos.min])/2
        left <- id3.cut.points(values[1:(pos.min-1)], classes[1:(pos.min-1)])
        right <- id3.cut.points(values[pos.min:length(values)],
                            classes[pos.min:length(classes)])
        return(c(left, cut.point, right))
    } else {
        return(vector())
    }
}


#' Entropy of the data.
#'
#' @param classes vector with the attribute classes.
#' @return Entropy of the given data.
id3.entropy <- function(classes){
    ## count of elements for each class
    cis <- summary(as.factor(classes))
    ## total number of elements
    s <- length(classes)
    ## entropy
    ent <- -sum(cis/s * log2(cis/s))
}


#' Entropy of a partition.
#'
#' @param classes vector with the attribute classes.
#' @param split.point index of the element that separates the partitions.
#' @return Entropy of the partition.
id3.entropy.partition <- function(classes, split.point){
    ## split the vector classes
    left <- classes[1:(split.point-1)]
    right <- classes[split.point:length(classes)]
    ## entropy
    ent <- (length(left) * id3.entropy(left)
            + length(right) * id3.entropy(right)) / length(classes)
}
