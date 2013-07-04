\name{train}
\alias{train}
\title{Train a model for the classification using the association rules.}
\usage{
  train(dataset, intervals, method.mfi = "arules",
    support = 0.1, confidence = 0.8)
}
\arguments{
  \item{dataset}{training set with the values discretized.}

  \item{intervals}{list with members named with genes'
  names and each containing a list with the intervals used
  for discretize that gene.}

  \item{method.mfi}{character string specifing the method
  to use for compute the maximal frequent itemsets.
  Choices are "arules".}

  \item{support}{a numeric value for the minimal support of
  an itemset.  The default is 0.1.}

  \item{confidence}{a numeric value for the minimal
  confidence of a rule.  The default is 0.8.}
}
\value{
  A model for the classification.  List with a member for
  each class, named using the class name and containing a
  list with the itemsets of the left-hand-side of the
  association rules.  An itemset is a list of items, where
  each of them is represented with a list containing the
  entries: "gene" with the name of the gene, "lower" and
  "upper" for the bounds of the interval.
}
\description{
  This function generate association rules for each class
  in the training set. An association rule has in the
  right-hand-side one class and in the left-hand-side a
  maximal frequent itemset, this is computed using the
  subset of the training set with only the entries with the
  class in the right-hand-side of the association rule.
}

