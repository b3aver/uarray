\docType{package}
\encoding{utf8}
\name{uarray-package}
\alias{uarray-package}
\title{Microarray data classification}
\description{
  Microarray data classification
}
\details{
  \describe{ \item{read}{Read a CSV file with tab separated
  fields} \item{gfilter}{Filter genes}
  \item{gdiscretize}{Discretize gene expressions in
  intervals} \item{train}{Train the classification model}
  \item{classify}{Classify an entry} }

  Available datasets from
  \url{http://ferrolab.dmi.unict.it/midclass.html}
  \itemize{ \item Brain_Cancer.csv \item BRC_01.csv \item
  BRC_2.csv \item Gastric_Cancer.csv \item
  Lung_Cancer_1.csv \item Lung_Cancer_2.csv \item
  Lymphoma_Cancer.csv \item Melanoma_Cancer.csv \item
  Myeloma_Cancer.csv \item Pacreatic_Cancer.csv \item
  Prostate_Cancer.csv } the paths to them can be retrieved
  with \code{system.file("extdata", "<dataset filename>",
  package="uarray")}
}
\examples{
\dontrun{
trainingsetFN <- "data/trainingset.csv"
## or for a dataset provided with the package
## trainingsetFN <- system.file("extdata", "Brain_Cancer.csv",
##                               package="uarray")
trainingset <- read(trainingsetFN)
filteredTS <- gfilter(trainingset)
discretizedTS <- gdiscretize(filteredTS)
classificationModel <- train(discretizedTS$dataset, discretizedTS$intervals)

newsampleFN <- "data/newsample.csv"
newsample <- read(newsampleFN)
classify(newsample, classificationModel)

accuracy(validate(trainingset))
}
}
\author{
  Paolo C. Sberna <reliablebeaver86-cs@yahoo.it>
}
\references{
  Rosalba Giugno, Alfredo Pulvirenti, Luciano Cascione,
  Giuseppe Pigola, Alfredo Ferro. MIDClass: Microarray Data
  Classification by Association Rules and Gene Expression
  Intervals.
  \url{http://ferrolab.dmi.unict.it/midclass.html}

  Smyth, G. K. Linear models and empirical Bayes methods
  for assessing differential expression in microarray
  experiments. Statistical Applications in Genetics and
  Molecular Biology, (2004), Vol. 3, No. 1, Article 3.
  \url{http://www.bepress.com/sagmb/vol3/iss1/art3}

  J. Alcalá-Fdez, L. Sánchez, S. García, M.J. del Jesus, S.
  Ventura, J.M. Garrell, J. Otero, C. Romero, J. Bacardit,
  V.M. Rivas, J.C. Fernández, F. Herrera. KEEL: A Software
  Tool to Assess Evolutionary Algorithms to Data Mining
  Problems. Soft Computing 13:3 (2009) 307-318, doi:
  10.1007/s00500-008-0323-y.

  J. Alcalá-Fdez, A. Fernandez, J. Luengo, J. Derrac, S.
  García, L. Sánchez, F. Herrera. KEEL Data-Mining Software
  Tool: Data Set Repository, Integration of Algorithms and
  Experimental Analysis Framework. Journal of
  Multiple-Valued Logic and Soft Computing 17:2-3 (2011)
  255-287.

  Michael Hahsler, Christian Buchta, Bettina Grün and Kurt
  Hornik. Introduction to arules – A computational
  environment for mining association rules and frequent
  item sets
}
\seealso{
  \code{\link[limma]{limma}} \code{\link[=apriori]{arules}}
}

