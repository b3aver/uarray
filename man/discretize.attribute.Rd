\name{discretize.attribute}
\alias{discretize.attribute}
\title{Discretize the values of an attribute.}
\usage{
  discretize.attribute(values, classes, cut.points.fun)
}
\arguments{
  \item{values}{vector with the continuous values to
  discretize.}

  \item{classes}{vector with the classes associated with
  the values in \code{values}.}

  \item{cut.points.fun}{function that takes \code{values}
  and \code{classes} and return a vector with the cut
  points for those values.}
}
\value{
  A list with the members: vector \code{values} with the
  given values discretized and \code{intervals} that is a
  list with the intervals used for discretize the values.
}
\description{
  Discretize the values of an attribute.
}

