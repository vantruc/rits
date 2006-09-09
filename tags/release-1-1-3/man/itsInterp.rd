\keyword{ts}
\name{itsInterp}
\alias{itsInterp}
\alias{locf}
\title{Interpolation Functions for Irregular Time-Series Objects}
\description{
  Interpolation functions for objects of class \code{"its"}.
}
\usage{
locf(x)

}

\arguments{
  \item{x}{an object of class \code{"its"} or NULL}
}

\details{

\code{locf} 'Last Observation Carry Forward'. NAs are replaced by the last preceding 
valid observation within the series.

}

\value{
An object of class \code{"its"}.
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
}

\examples{
x <- newIts(11:40,ncol=3)
x[1:2,1] <- NA
x[3:4,2] <- NA
x[9:10,3] <- NA
print(x)
print(locf(x))
}
