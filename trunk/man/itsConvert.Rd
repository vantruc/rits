\keyword{ts}
\name{itsConvert}
\alias{itsConvert}
\alias{as.data.frame.its}
\alias{as.list.its}
\title{Conversion for its objects}
\description{
  Conversions to basic types for \code{"its"}.
}
\usage{
as.list.its(x,...)
as.data.frame.its(x, row.names = NULL, optional = FALSE)
}
\arguments{
  \item{x}{an object of class \code{"its"}}
	\item{\dots}{further arguments to \code{as.list}}
	\item{row.names}{character vector giving the row names for the data frame.}
	\item{optional}{logical. If 'TRUE', setting row names and converting column names (to syntactic names) is optional.}
}
\details{
	Conversion ot basic types
}
\value{

  For \code{as.list.its} a list
	for \code{as.data.frame.its} a data frame

}
\author{Gabor Grothendieck}
