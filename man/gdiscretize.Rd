\name{gdiscretize}
\alias{gdiscretize}
\title{Produce set of intervals.}
\usage{
  gdiscretize(dataset, method = "id3", num.bin = 10)
}
\arguments{
  \item{dataset}{training set to be discretized.}

  \item{method}{character string specifing the method to
  use.  Choices are "id3", "ewib", "cacc".}

  \item{num.bin}{number of bins for EWIB method.}
}
\value{
  A list with the members: \code{dataset} with the
  discretized dataset and \code{intervals} that is a list
  with members named with genes names and each containing a
  list with the intervals used for discretize that gene.
}
\description{
  Produce set of intervals.
}

