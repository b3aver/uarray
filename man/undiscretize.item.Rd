\name{undiscretize.item}
\alias{undiscretize.item}
\title{Given an item make explicit the discretized interval.}
\usage{
  undiscretize.item(item, intervals)
}
\arguments{
  \item{item}{list containing the entries: "gene" with the
  name of the gene and "value" for the discretized value.}

  \item{intervals}{list with members named with genes'
  names and each containing a list with the intervals used
  for discretize that gene.}
}
\value{
  Modified item, that is a list containing the entries:
  "gene" with the name of the gene, "lower" and "upper" for
  the bounds of the interval.
}
\description{
  Given an item make explicit the discretized interval.
}

