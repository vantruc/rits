\keyword{ts}
\name{itsCumdif}
\alias{itsCumdif}
\alias{cumsum}
\alias{diff}
\alias{cumsum,its-method}
\alias{diff,its-method}

\title{Cumulation, Differencing for Irregular Time-Series Objects}
\description{
  Cumulation, differencing for objects of class \code{"its"}.
}
\section{Usage}{

cumsum(x)
diff(x,lag=1)

}
\section{Arguments}{
\describe{
  \item{x}{an object of class \code{"its"}}
  \item{lag}{an integer number of lags}
  }
}

\details{

\code{cumsum} and \code{diff} perform the cumulative sum and difference of each
column in turn.  In \code{diff}, the first \code{lag} rows are discarded.

}

\value{

An object of class \code{"its"}

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
  \code{\link{itsArith}}
  \code{\link{itsInterp}}  
}

\examples{
b <- newIts(1:60,ncol=3)
cumsum(b)
diff(b,lag=2)
}
