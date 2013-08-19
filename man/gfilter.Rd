\name{gfilter}
\alias{gfilter}
\title{Select discriminant gene expression values.}
\usage{
  gfilter(dataset, method = "limma", number = 10,
    p.value = 1)
}
\arguments{
  \item{dataset}{training set to be filtered.}

  \item{method}{character string specifing the method to
  use.  Choices are "limma".}

  \item{number}{maximum number of genes to list.}

  \item{p.value}{cutoff value for adjusted p-values. Only
  genes with lower p-values are listed.}
}
\value{
  filtered dataset
}
\description{
  Apply the T-Test to the gene expression values.
}

