\keyword{ts}
\name{itsFin}
\alias{itsFin}
\alias{accrueIts}
\title{Financial Functions for Irregular Time-Series Objects}
\description{
  Financial functions for objects of class \code{"its"}.
}
\usage{
accrueIts(x,daysperyear=365)
}
\arguments{
  \item{x}{an object of class \code{"its"}}
  \item{daysperyear}{integer, representing days per year for accrual}
}
\details{
  \code{accrueIts} Accrues an annual rate stored in x, expressed as a
  decimal (not a percentage), based on the difference of the time-stamps.
  The accrued value is not cumulated, it is a per-period return.
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
  \code{\link{itsInterp}}  
}
\examples{
a <- matrix(c(seq(by=24*60*60,length=20),1:20,41:60),nrow=20,ncol=3)
b <- as.its(a)
accrueIts(b[which(weekdayIts(b)),]/100,daysperyear=365)
}
