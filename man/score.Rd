\name{score}
\alias{score}
\title{Evaluate the scoring function.}
\usage{
  score(sample, rule)
}
\arguments{
  \item{sample}{list with the expression data for each gene
  in the microarray to classify.  The entries of the list
  are named using the genes' names.}

  \item{rule}{list with the left-hand-side itemset, where
  every item is represented with a list containing the
  entries: "gene" with the name of the gene, "lower" and
  "upper" for the bounds of the interval.}
}
\value{
  The value of the scoring function.
}
\description{
  Evaluate the scoring function.
}

