\name{discretize.attribute}
\alias{discretize.attribute}
\title{Discretize the values of an attribute.}
\usage{
  discretize.attribute(cut.points.fun, values, ...)
}
\arguments{
  \item{cut.points.fun}{function that takes \code{values}
  and \code{...} and returns a vector with the cut points
  for those values.}

  \item{values}{vector with the continuous values to
  discretize.}

  \item{...}{any other argument to be passed to
  \code{cut.points.fun}}
}
\value{
  A list with the members: vector \code{values} with the
  given values discretized and \code{intervals} that is a
  list with the intervals used for discretize the values.
}
\description{
  Discretize the values of an attribute.
}

