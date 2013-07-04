\name{parse.item}
\alias{parse.item}
\title{Given an item returned from arules make explicit the discretized interval.}
\usage{
  parse.item(item)
}
\arguments{
  \item{item}{string in the form <gene name>=<discretized
  value>.}
}
\value{
  Modified item, that is a list containing the entries:
  "gene" with the name of the gene and "value" for the
  discretized value.
}
\description{
  Given an item returned from arules make explicit the
  discretized interval.
}

