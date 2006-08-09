\keyword{ts}
\name{itsLags}
\alias{itsLags}
\alias{lagIts}
\alias{lagdistIts}
\title{Lag Functions for Irregular Time-Series Objects}
\description{
  Lag functions for objects of class \code{"its"}.
}
\usage{
lagIts(x,k=1)
lagdistIts(x,kmin,kmax)
}
\arguments{
  \item{x}{an object of class \code{"its"}}
  \item{k, kmin, kmax}{integer lag; positive value mean earlier data is
    assigned to a later timestamp}
}
\details{
  \code{lagIts} returns an object with the same time-stamps, but with the data shifted.
  \code{lagdistIts} applies lagIts over a range of lags, and appends these columns
}
\value{

  An object of class \code{"its"}.

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
b <- newIts(1:10)
lagIts(b)
lagdistIts(b[,1],1,3)
}
