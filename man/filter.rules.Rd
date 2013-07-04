\name{filter.rules}
\alias{filter.rules}
\title{Remove the rules with low confidence}
\usage{
  filter.rules(model, dataset, confidence = 0.8)
}
\arguments{
  \item{model}{list with a member for each class, named
  using the class name and containing a list with the
  itemsets of the left-hand-side of the association rules.
  An itemset is a list of items, where each of them is
  represented with a list containing the entries: "gene"
  with the name of the gene and "value" for the discretized
  value.}

  \item{dataset}{training set with the values discretized.}

  \item{confidence}{a numeric value for the minimal
  confidence of a rule.  The default is 0.8.}
}
\value{
  This function returnes only the rules that have a
  confidence higher than the given minimum confidence:
  \code{confidence}.
}
\description{
  The given \code{rules} are filtered using the confidence
  measure.
}

