\name{gdiscretize.id3}
\alias{gdiscretize.id3}
\title{Produce set of intervals using the ID3 discretization method.}
\usage{
  gdiscretize.id3(dataset)
}
\arguments{
  \item{dataset}{training set to be discretized}
}
\value{
  A list with the members: \code{dataset} with the
  discretized dataset and \code{intervals} that is a list
  with members named with genes names and each containing a
  list with the intervals used for discretize that gene.
}
\description{
  Produce set of intervals using the ID3 discretization
  method.
}

