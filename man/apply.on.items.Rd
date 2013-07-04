\name{apply.on.items}
\alias{apply.on.items}
\title{Apply a function on the items.}
\usage{
  apply.on.items(model, fun, ...)
}
\arguments{
  \item{model}{list with a member for each class, named
  using the class name and containing a list with the
  itemsets of the left-hand-side of the association rules.
  An itemset is a list of items.}

  \item{fun}{function that takes an item and other
  arguments and return the item modified.}

  \item{...}{any other argument to be passed to \code{fun}}
}
\value{
  The given model with every item substituted with the
  result of fun applied to the item.
}
\description{
  Apply a function on the items.
}

