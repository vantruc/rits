\keyword{ts}
\keyword{arith}
\name{itsArith}
\alias{itsArith}
\alias{Arith,its,its-method}
\alias{Arith.its}
\alias{+.its}
\alias{-.its}
\alias{*.its}
\alias{/.its}
\alias{^.its}

\title{Arithmetic Methods for Irregular Time-Series Objects}
\description{
  Arithmetic methods for objects of class \code{"its"}.
}

\arguments{
  \item{e1}{its object}
	\item{e2}{its object}
}
\details{
Date matching is performed then the arithmatic is done on the intersection of the dates of the two arguments.
The arithmetic operators return numeric vectors containing the result of the 
element-by-element operations.

Note that the matrix multiplication operator, %*%, is inherited from matrix,
and the result of a matrix multiplication is a matrix, not an \code{"its"}.
The resulting matrix can be converted back to its using the function its() 
- see examples.
}

\value{

The returned object is an object of class \code{"its"}, having the same number
of columns as the two arguments, however, the number of rows will be the length
of the intersection of the dates of the two arguments.

}
\author{Giles Heywood}

\seealso{
  \code{\link{ts}},
  \code{\link{POSIXct}},
  \code{\link{itsFile}},
  \code{\link{itsLags}}
  \code{\link{itsJoin}}
  \code{\link{itsTimes}}
  \code{\link{itsSubset}}
  \code{\link{itsFin}}
  \code{\link{itsDisp}}
  \code{\link{itsInfo}}
  \code{\link{itsCumdif}}
  \code{\link{itsInterp}}  
}

\examples{
b <- newIts(1:30,ncol=3)
c <- newIts(1:10,ncol=3)[1:5,]
b+c
b+b-2*b
b/b
b\%*\%diag(ncol(b))
its(b\%*\%diag(ncol(b))) 
}
