\keyword{ts}
\name{itsInfo}
\alias{itsInfo}
\alias{start}
\alias{end}
\alias{summary}
\alias{start,its-method}
\alias{end,its-method}
\alias{summary,its-method}

\title{Summary Information for Irregular Time-Series Objects}
\description{
  Summary information for objects of class \code{"its"}.
}
\section{Usage}{

start(x,format=its.format(),...)
end(x,format=its.format(),...)
summary(object)

}
\section{Arguments}{
\describe{
  \item{x, object}{an object of class \code{"its"}}
  \item{format}{a formatting string, see \code{\link{format.POSIXct}}}
  \item{\dots}{further arguments passed to or from other methods:
    for \code{start} and \code{end}, passed to \code{\link{format.POSIXct}.} }
    }
}
\details{

Summary returns the same statistics as summary for a matrix, plus the number of
NA and non-NA data points for each series, and the standard deviation.

Start and end return the dates corresponding to the first and last rows,
respectively.

}

\value{

For \code{start}, \code{end}, a formatted text representation of the first and last times
For \code{summary}, a table of summary statistics for each series
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
b <- newIts(1:30,ncol=3)
start(b,format="\%y-\%m-\%d")
end(b)
summary(b)
}
