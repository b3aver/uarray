\name{supp}
\alias{supp}
\title{Compute the absolute support of an itemset.}
\usage{
  supp(itemset, dataset)
}
\arguments{
  \item{itemset}{list of items, where each of them is
  represented with a list containing the entries: "gene"
  with the name of the gene and "value" for the discretized
  value.}

  \item{dataset}{dataset with the values discretized.}
}
\value{
  Absolute support of the itemset for the given dataset.
}
\description{
  Note that this function computes the absolute support and
  not the relative.
}

