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
#' classificationModel <- train(discretizedTS)
#'
#' testdataFN <- "data/testdata.tsv"
#' testdata <- read(testdataFN)
#' classify(classificationModel, testdata)
#' }
#'
#' @references
#' \describe{
#'   \item{MIDClass}{Microarray Data Classification by Association Rules and
#'                   Gene Expression Intervals}
#'   \item{LIMMA}{Linear Models for Microarray Data}
#'   \item{KEEL}{Knowledge Extraction based on Evolutionary Learning}
#'  }
#'
#' @seealso \code{\link[limma]{limma}}
#'
#' @author Paolo C. Sberna <reliablebeaver86-cs@@yahoo.it>
#' @import limma
#' @docType package
#' @name uarray-package
NULL
