\keyword{ts}
\name{itsFile}
\alias{itsFile}
\alias{readcsvIts}
\alias{writecsvIts}
\title{File Operations for Irregular Time-Series Objects}
\description{
  File read and write operations for objects of class \code{"its"}.
}
\usage{
readcsvIts(filename,informat=its.format(),outformat=its.format(),tz="",usetz = FALSE,header=TRUE,...)
writecsvIts(x,filename,format=its.format(),tz="",usetz = FALSE,col.names=NA,
sep=",",split=FALSE,...)
}
\arguments{
  \item{filename}{filename}
  \item{x}{an object of class \code{"its"}}
  \item{format, informat, outformat}{formatting related arguments, see \code{\link{format.POSIXct}}.}
  \item{tz}{what timezone the its is in}
  \item{usetz}{whether to include the tzone information in the saved file}
  \item{header}{see \code{\link{read.csv}}}
  \item{col.names, sep}{see \code{\link{write.table}}}
  \item{split}{when columns exceed 255 in number, flags for splitting into numbered subfiles}
  \item{\dots}{further arguments passed to or from other methods: for
    \code{readcsvIts} passed to \code{\link{read.csv}}; for
    \code{writecsvIts} passed to \code{\link{write.table}}}
}
\details{
  \code{readcsvIts} reads from a .csv file to a matrix.  The first column is assumed to
  contain dates in text format specified by informat, which can optionally be
  reformatted into the text format outformat.  Both of these formats default to the
  format specified by \code{\link{its.format}}.  To convert the matrix to an its, use 
  \code{\link{its}} (see example)

  \code{writecsvIts} write an irregular time-series object to a text file.
}
\value{

  For \code{readcsvIts} a matrix

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
\dontrun{
b <- newIts(1:30,ncol=3)
fname <- tempfile()
# To write an irregular time-series object to a file one might use
writecsvIts(b,filename=fname)
# To read an irregular time-series object from a file one might use
its(readcsvIts(filename=fname))
unlink(fname)
}
}
