\name{gdiscretize.cacc}
\alias{gdiscretize.cacc}
\title{Produce set of intervals using the CACC discretization method.}
\usage{
  gdiscretize.cacc(dataset)
}
\arguments{
  \item{dataset}{training set to be discretized.}
}
\value{
  A list with the members: \code{dataset} with the
  discretized dataset and \code{intervals} that is a list
  with members named with genes names and each containing a
  list with the intervals used for discretize that gene.
}
\description{
  Produce set of intervals using the CACC discretization
  method.
}

