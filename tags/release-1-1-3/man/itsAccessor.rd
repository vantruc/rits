\keyword{ts}
\name{itsAccessor}
\alias{itsAccessor}
\alias{dates}
\alias{names}
\alias{core}
\alias{dates<-}
\alias{names<-}
\alias{core<-}
\alias{dates,its-method}
\alias{names,its-method}
\alias{core,its-method}
\alias{dates<-,its,POSIXt-method}
\alias{names<-,its,character-method}
\alias{core<-,its,matrix-method}
\title{Accessor, Assignment Functions for Irregular Time-Series Objects}
\description{
  Accessor & assignment functions for objects of class \code{"its"}.
}
\usage{
dates(x,...)
names(x)
core(x)
dates(x) <- value
names(x) <- value
core(x) <- value
}

\arguments{
  \item{x}{an object of class \code{"its"}}
	\item{\dots}{further arguments passed to or from other methods}
	\item{value}{value to be assigned into dates, names, or core}
}

\details{
\code{dates} an accessor function, to access the time-stamps of the object.

\code{names} an accessor function, to access the (column) names of the object.

\code{core} an accessor function, to access the numeric data of the object.

\code{dates} an assignment function to assign the time-stamps of the object.

\code{names} an assignment function to assign the (column) names of the object.

\code{core} an assignment function to assign the numeric data of the object.
}

\value{

  For \code{dates,...}  a vector of class \code{"POSIXct"}.
  For \code{names}  a vector of mode \code{"character"}.
  For \code{core}  a matrix of mode\code{"numeric"}.
  For \code{dates<-, names<-, and core<-} an object of class \code{"its"}.
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
x <- newIts(1:10)
dates(x)
names(x)
core(x)
dates(x) <- seq(from=Sys.time()+11*24*60*60,
            length.out=10,
            by="DSTday")
names(x) <- "B"
core(x) <- as.matrix(11:20)
}
