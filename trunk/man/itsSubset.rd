\keyword{ts}
\name{itsSubset}
\alias{itsSubset}
\alias{rangeIts}
\alias{extractIts}
\alias{x[i,j]}
\alias{[}
\alias{[,its-method}
\alias{[<-,its,its-method}
\title{Range and Extract for Irregular Time-Series Objects}
\description{
  Range and extract for objects of class \code{"its"}.
}
\usage{
rangeIts(x,start=dates(x)[1],end=dates(x)[nrow(x)],format=its.format(),...)
extractIts(x,weekday=FALSE,find=c("all","last","first"),period=c("week","month","year"),partials=TRUE,firstlast = FALSE,select)
x[i,j,dates]
}
\arguments{
  \item{x}{an object of class \code{"its"}}
  \item{start, end}{POSIXct or character representation of the start or end time-stamp, 
    if character, then the format is as specified by the argument \code{format}}
  \item{format}{format of \code{"start"} and \code{"end"} dates, see
        \code{\link{format.POSIXct}}.}
  \item{i,j}{indices specifying the parts to be extracted from the irregular
        time-series object}
  \item{dates}{POSIX dates specifying the timestamps of rows to be extracted from the irregular
        time-series object}  
  \item{\dots}{further arguments passed to \code{\link{as.POSIXct}}}
  \item{weekday}{logical, defines whether only weekdays are to be returned}
  \item{find}{to find the first, last, or all samples within each period}
  \item{period}{the period within which 'find' and/or 'select' operate}
  \item{partials}{defines whether the first (possibly incomplete) period is processed 
                for find=first, and whether the last is processed for find=last}
  \item{firstlast}{if TRUE, the first and last observations are returned, in addition to those observations selected by other criteria}
  \item{select}{an integer vector defining one or more days to select.  The integer 
                specifies \code{wday} (for period=week) or \code{mday} (for period=month).  See 
                \code{\link{as.POSIXlt}} for details}
}
\details{
  \code{rangeIts} selects a range of rows that fall between two times, specified
  in text format.

  \code{extractIts} selects a subset of rows that obey some sort of semi-regular rule
  such as monthends, weekdays, and so on.  The order of application is \code{weekday}, \code{find}, 
  then \code{select}.

  \code{x[i,j,dates]} extractor method for an irregular time-series: \code{i} and \code{dates}
  are mutually exclusive alternatives for specifying rows.  It proceeds as for a matrix, with the 
  exception that drop=FALSE is enforced, so the result always inherits from matrix.

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
  \code{\link{itsInterp}}  
}

\examples{
its.format("\%Y-\%m-\%d")
b <- newIts(start="2003-01-01",end="2003-01-20")
rangeIts(b,start = "2003-01-05" ,end= "2003-01-15")
rangeIts(b,start = ISOdate(2003,1,5,hour=0) ,end= ISOdate(2003,1,15,hour=0))
b[1:3,]
b[,1]
b[,dates=ISOdate(2003,1,1,hour=0,tz="")]
its.format("\%a \%d \%b \%Y")
c <- newIts()
extractIts(c,weekday=TRUE,period="month",find="last")  #the last weekdays of the month in c
}
