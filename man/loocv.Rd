\name{loocv}
\alias{loocv}
\title{Leave-One-Out Cross Validation}
\usage{
  loocv(dataset, method.filt = "limma",
    method.discr = "id3", method.mfi = "arules",
    number.filt = 10, p.value = 1, num.bin = 10,
    support = 0.1, confidence = 0.8)
}
\arguments{
  \item{dataset}{training set (with the values neither
  filtered nor discretized).}

  \item{method.filt}{character string specifing the
  filtering method to use.  Choices are "limma".}

  \item{method.discr}{character string specifing the
  discretization method.  Choices are "id3", "ewib",
  "cacc".}

  \item{method.mfi}{character string specifing the method
  to use for compute the maximal frequent itemsets.
  Choices are "arules". #'}

  \item{number.filt}{maximum number of genes to list in
  filtering.}

  \item{p.value}{cutoff value for adjusted p-values.  Only
  genes with lower p-values are listed.}

  \item{num.bin}{number of bins for EWIB method.}

  \item{support}{a numeric value for the minimal support of
  an itemset.  The default is 0.1.}

  \item{confidence}{a numeric value for the minimal
  confidence of a rule.  The default is 0.8.}
}
\value{
  Confusion matrix, that is a matrix with rows for actual
  classes and columns for predicted class, the entry (i, j)
  is the number of samples of class i classified with class
  j.
}
\description{
  Leave-One-Out Cross Validation

  Compute the confusion matrix using the Leave-One-Out
  Cross Validation.
}

