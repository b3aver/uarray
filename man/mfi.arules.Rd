\name{mfi.arules}
\alias{mfi.arules}
\title{Generate the maximal frequent itemsets using the arules package.}
\usage{
  mfi.arules(dataset, support = 0.1)
}
\arguments{
  \item{dataset}{training set with the values discretized.}

  \item{support}{a numeric value for the minimal support of
  an itemset.  The default is 0.1 as in arules.}
}
\value{
  Maximal frequent itemsets.  List with a member for each
  class, named using the class name and containing a list
  with the itemsets of the left-hand-side of the
  association rules.  An itemset is a list of items, where
  each of them is represented with a list containing the
  entries: "gene" with the name of the gene and "value" for
  the discretized value.
}
\description{
  Generate the maximal frequent itemsets using the arules
  package.
}

