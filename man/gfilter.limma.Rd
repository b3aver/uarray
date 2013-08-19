\name{gfilter.limma}
\alias{gfilter.limma}
\title{Select discriminant gene expression values using the LIMMA package.}
\usage{
  gfilter.limma(dataset, number = 10, p.value = 1)
}
\arguments{
  \item{dataset}{training set to be filtered}

  \item{number}{maximum number of genes to list.
  \code{number=Inf} for list all genes with adjusted
  p-values below a specified value.}

  \item{p.value}{cutoff value for adjusted p-values. Only
  genes with lower p-values are listed.}
}
\value{
  filtered dataset
}
\description{
  Select discriminant gene expression values using the
  LIMMA package.
}
\references{
  Smyth, G. K. (2004). Linear models and empirical Bayes
  methods for assessing differential expression in
  microarray experiments. Statistical Applications in
  Genetics and Molecular Biology, Vol. 3, No. 1, Article 3.
  http://www.bepress.com/sagmb/vol3/iss1/art3
}
\seealso{
  \code{\link[limma]{limma}} \code{\link{lmFit}}
  \code{\link{eBayes}} \code{\link{topTable}}
}

