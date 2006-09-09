\keyword{ts}
\name{itsTimes}
\alias{itsTimes}
\alias{daysecondIts}
\alias{weekdayIts}
\title{Time Functions for Irregular Time-Series Objects}
\description{
  Time functions for objects of class \code{"its"}.
}
\usage{
daysecondIts(x,...)
weekdayIts(x,...)
}

\arguments{
  \item{x}{an object of class \code{"its"}}
  \item{\dots}{further arguments passed to \code{\link{as.POSIXlt}}}
}

\details{
  \code{daysecondIts} returns the number of seconds since midnight.

  \code{weekdayIts} tests which entries of an  irregular time-series object are
  time-stamped with weekdays.

}

\value{

  For \code{daysecondIts} a vector of decimal numbers representing the number of seconds.

  For \code{weekdayIts}  a vector of \code{"logical"} representing the test results
  for each time.

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
\dontrun{
its.format("\%Y-\%m-\%d \%A")
b <- newIts()
print(b)
daysecondIts(b)
weekdayIts(b)
its.format("\%Y-\%m-\%d")
}
}
