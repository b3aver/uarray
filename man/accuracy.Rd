\name{accuracy}
\alias{accuracy}
\title{Compute the accuracy of a model.}
\usage{
  accuracy(confusion.matrix)
}
\arguments{
  \item{confusion.matrix}{a matrix with rows for actual
  classes and columns for predicted class, the entry (i, j)
  is the number of samples of class i classified with class
  j.}
}
\value{
  The computed accuracy of the model, that is the
  percentage of training samples correctly classified.
}
\description{
  Compute the accuracy of a model.
}

