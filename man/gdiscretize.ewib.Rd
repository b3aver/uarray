\name{gdiscretize.ewib}
\alias{gdiscretize.ewib}
\title{Produce set of intervals using the EWIB discretization method.}
\usage{
  gdiscretize.ewib(dataset, num.bin = 10)
}
\arguments{
  \item{dataset}{training set to be discretized}

  \item{num.bin}{number of bins}
}
\value{
  A list with the members: \code{dataset} with the
  discretized dataset and \code{intervals} that is a list
  with members named with genes names and each containing a
  list with the intervals used for discretize that gene.
}
\description{
  Produce set of intervals using the EWIB discretization
  method.
}

