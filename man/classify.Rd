\name{classify}
\alias{classify}
\title{Classify a sample using the given model.}
\usage{
  classify(sample, model)
}
\arguments{
  \item{sample}{list with the expression data for each gene
  in the microarray to classify.  The entries of the list
  are named using the genes' names.}

  \item{model}{list with a member for each class, named
  using the class name and containing a list with the
  itemsets of the left-hand-side of the association rules.
  An itemset is a list of items, where each of them is
  represented with a list containing the entries: "gene"
  with the name of the gene, "lower" and "upper" for the
  bounds of the interval.}
}
\value{
  The computed class for the given \code{sample}.
}
\description{
  The class of a sample is the class whose rules are
  maximally satisfied using a scoring function.
}

