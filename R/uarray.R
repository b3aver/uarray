#' Microarray data classification
#'
#' Microarray data classification
#'
#' \describe{
#'   \item{read}{Read a CSV file with tab separated fields}
#'   \item{gfilter}{Filter genes}
#'   \item{gdiscretize}{Discretize gene expressions in intervals}
#'   \item{train}{Train the classification model}
#'   \item{classify}{Classify an entry}
#' }
#'
#' @examples
#' \dontrun{
#' trainingsetFN <- "data/trainingset.csv"
#' trainingset <- read(trainingsetFN)
#' filteredTS <- gfilter(trainingset)
#' discretizedTS <- gdiscretize(filteredTS)
#' classificationModel <- train(discretizedTS$dataset, discretizedTS$intervals)
#'
#' newsampleFN <- "data/newsample.csv"
#' newsample <- read(newsampleFN)
#' classify(newsample, classificationModel)
#' }
#'
#' @encoding utf8
#' @references
#' Rosalba Giugno, Alfredo Pulvirenti, Luciano Cascione, Giuseppe Pigola,
#' Alfredo Ferro.
#' MIDClass: Microarray Data Classification by Association Rules and Gene
#' Expression Intervals
#'
#' Smyth, G. K. (2004).
#' Linear models and empirical Bayes methods for assessing differential
#' expression in microarray experiments.
#' Statistical Applications in Genetics and Molecular Biology, Vol. 3, No. 1,
#' Article 3.
#' \url{http://www.bepress.com/sagmb/vol3/iss1/art3}
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
#' Michael Hahsler, Christian Buchta, Bettina Grün and Kurt Hornik.
#' Introduction to arules – A computational environment for mining association
#' rules and frequent item sets
#'
#' @seealso \code{\link[limma]{limma}} \code{\link[=apriori]{arules}}
#'
#' @author Paolo C. Sberna <reliablebeaver86-cs@@yahoo.it>
#' @import limma arules
#' @docType package
#' @name uarray-package
NULL
