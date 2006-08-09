\keyword{ts}
\name{itsJoin}
\alias{itsJoin}
\alias{union}
\alias{union,its,NULL-method}
\alias{union,NULL,its-method}
\alias{union,its,its-method}
\alias{intersect}
\alias{intersect,its,NULL-method}
\alias{intersect,NULL,its-method}
\alias{intersect,its,its-method}
\alias{alignedIts}
\alias{appendIts}
\alias{collapseIts}
\title{Join Functions for Irregular Time-Series Objects}
\description{
  Join functions for objects of class \code{"its"}.
}
\usage{
union(x,y)
intersect(x,y)
alignedIts(obj1,obj2,print=FALSE)
appendIts(obj1,obj2,but=TRUE,matchnames=TRUE)
collapseIts(x)
}

\arguments{
  \item{x, y}{an object of class \code{"its"} or NULL}
  \item{obj1,obj2}{object of class \code{"its"}}
  \item{print}{logical flag to display summary information}
  \item{but}{logical flag controls whether overlap is disallowed}
  \item{matchnames}{logical flag controls whether names must match}
}

\details{

\code{union} has a number of time values (rows) which is determined by the union
of the time-stamps of the two inputs.  The number of columns is the sum of the
number of columns of the two inputs.

\code{intersect} has a number of time values (rows) which is determined by the
intersect of the time-stamps of the two inputs.  The number of columns is the sum
of the number of columns of the two inputs.

\code{alignedIts} selects the rows from two inputs which have identical time-stamps.

\code{appendIts} appends one object to the other, removing overlapping data from the
later object, optionally checking that the column names match.  Overlapping data
must match.

\code{collapseIts} checks for columns with the same names, using dimnames(x)[[2]].
columns with the same names are required to have the same numeric values in each row, but are
allowed NAs.  The numeric data is combined, and the resulting object has unique
column names - this will in general result in a reduction in the number of columns.

}

\value{
For \code{union}, \code{intersect}, \code{appendIts} an object of class \code{"its"}.

For \code{alignedIts}, a list of two objects of class \code{"its"}
}

\author{Giles Heywood}

\seealso{
  \code{\link{ts}},
  \code{\link{POSIXct}},
  \code{\link{itsFile}},
  \code{\link{itsLags}},
  \code{\link{itsJoin}},
  \code{\link{itsTimes}},
  \code{\link{itsSubset}},
  \code{\link{itsFin}},
  \code{\link{itsDisp}},
  \code{\link{itsInfo}},
  \code{\link{itsCumdif}},
  \code{\link{itsArith}}
  \code{\link{itsInterp}}  
}

\examples{
its.format("\%Y-\%m-\%d")
b <- newIts(1:30,ncol=3,start="2003-01-01",end="2003-01-10")
union(b,diff(b))
intersect(b,diff(b))
alignedIts(b,diff(b))
b1 <- newIts(1:30,ncol=3,start="2003-01-11",end="2003-01-20")
appendIts(b,b1)
c <- union(b,b*NA)
c[2,4] <- 99
c[2,1] <- NA
print(c)
collapseIts(c)
}
