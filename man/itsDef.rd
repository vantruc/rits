\keyword{ts}
\name{itsDef}

\alias{its}
\alias{is.its}
\alias{as.its}
\alias{as.its.default}
\alias{as.its.zoo}
\alias{its.format}
\alias{newIts}

\title{Irregularly Spaced Time-Series}

\description{
  The function \code{its} is used to create irregular time-series
  objects from user-supplied data and time-stamps.
  \code{newIts} is used to create semi-regular time-series
  objects from user-supplied data, and rule for generating time-stamps.
  \code{as.its} coerces an object to an irregularly spaced
  time-series. \code{is.its} tests whether an object is an irregularly
  spaced time series.
  }

\usage{
its(x,
dates=as.POSIXct(x=strptime(dimnames(x)[[1]],format=its.format())),
names=dimnames(x)[[2]],
format=its.format(),...)

newIts(x=NA,start=format(Sys.Date(),format=its.format()),
end,ncol=1,by="DSTday",extract=FALSE,format=its.format(),tz="",...)

as.its(x,...)

is.its(object)

its.format(formatDefault=NULL)
}

\arguments{
  \item{dates}{a vector of class \code{"POSIXct"}
    representing the time-stamps of the irregular time-series
    object. The elements of the numeric vector are construed as the
    number of seconds since the beginning of 1970, see \code{\link{POSIXct}}.}
  \item{start, end}{POSIXct or character representation of the start or end time-stamp, 
    if character, then the format is as specified by the argument \code{format}}
  \item{ncol}{number of columns of synthetic sequence of dates}
  \item{by}{time increment for synthetic sequence of dates, see \code{\link{seq.POSIXt}}}
  \item{extract}{logical flag: if TRUE, a subset of the synthetic sequence of dates is extracted, 
        see \code{\link{extractIts}}}
  \item{x}{a numeric matrix representing the values of the
    irregular time-series object.  In the case of coercion in as.its, the first
    column is taken to be the time-stamps, in seconds since the beginning
    of 1970, see \code{\link{POSIXct}}.}
  \item{object} { }
  \item{names}{a vector of mode character}
  \item{format}{a formatting string, see \code{\link{format.POSIXct}}, defaults to 
                \code{its.format()}}
  \item{formatDefault}{a formatting string, see \code{\link{format.POSIXct}},
    defaults to \code{"\%Y-\%m-\%d"} if \code{formatDefault} is not specified.}
	\item{tz}{time zone of dates of its object}
  \item{\dots}{further arguments passed to or from other methods:
    for \code{its} passed to \code{\link{format.POSIXct}}.;
    for \code{as.its} passed to \code{\link{its}}.;
    for \code{newIts} passed to \code{\link{extractIts}}.}
    }

\details{
 The function \code{its} is used to create irregular time-series objects,
 which have (S4) class "its". An object of class "its" is a matrix with rows indexed by a time-stamp
 of class "POSIXct". Unlike objects of class "ts", it can be used to
 represent irregularly spaced time-series.  The object consists of a
 matrix, with a single slot, the named POSIX vector named "dates".
 An object of class "its" inherits matrix arithmetic methods.  The matrix
 has dimnames: dimnames[[1]] is populated with a text representation of
 "dates", using a format which is defined by the function its.format. These
 dates are not used in computations - all computations use the 
 POSIX representation.  The dates are required to be in ascending order.
 
 When matrix multiplication is applied to an "its", the result is of class
 matrix.  It is possible to restore the "its" class (see examples) - its() 
 is in this sense idempotent i.e. its(mat)==its(its(mat)).  Note however that
 the dates will be taken from dimnames[[1]], so the accuracy of this
 operation depends on the format of the dates.

 \code{newIts} is a utility for creating a new "its" using a series of 'semi-regular' 
 time-stamps, such as weekday, weekly, monthend etc.  Conceptually the date sequence
 generation has two parts. The first part is the generation of a sequence using
 \code{\link{seq.POSIXt}} - the arguments from, to, and by are passed to this function.  The second 
 part (which is optional, and applies only if extract=TRUE) is an extraction, 
 performed by \code{extractIts}. See \code{\link{extractIts}} for details of the arguments,
 which are passed via '...' .

 The function \code{its.format} assigns a private variable and returns its value. The 
 value of this default format persists in the session until reset.  The purpose of the
 function is one of convenience: to access and/or assign the default text format for dates 
 in the "its" package, and hence reduce the need to define the format repeatedly in a session.

}

\value{
For \code{its}, \code{newIts} and \code{as.its}, an object of class \code{"its"}, inheriting
from matrix, with a single slot named \code{'dates'}, which is a vector of class \code{POSIXct}

For \code{is.its}, a logical representing the result of a test for class membership

For \code{its.format}, a text representation of dates formatting to be used in the "its" package,
see \code{\link{format.POSIXct}}
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
  \code{\link{itsInterp}}  
  }

\examples{
its.format("\%Y-\%m-\%d")    #defines text format of dates read from dimnames
mat <- structure(1:6,dim=c(2,3),dimnames=list(c("2003-01-01","2003-01-04"),letters[1:3]))
its(mat)
its.format("\%Y\%m\%d")    #defines text format of dates written to dimnames
times <- as.POSIXct(strptime(c("1999-12-31 01:00:00","2000-01-01 02:00:00"),format="\%Y-\%m-\%d \%X"))
its(mat,times)
its.format("\%Y-\%m-\%d \%X")
its(mat,times)
is.its(its(mat,times))
its.format("\%Y\%m\%d \%X")   #defines text format of dates written to dimnames
as.its(mat)
its.format("\%a \%d \%b \%Y")
newIts(start="2003-09-30",end="2005-05-05",format="\%Y-\%m-\%d",period="month",find="last",extract=TRUE,weekday=TRUE)
newIts(start=ISOdate(2003,12,24,0),end=ISOdate(2004,1,10),extract=TRUE,weekday=TRUE)
its.format("\%Y\%m\%d") 
as(newIts(),"data.frame")
}
