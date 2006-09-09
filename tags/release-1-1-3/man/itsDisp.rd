\keyword{ts}
\name{itsDisp}
\alias{itsDisp}
\alias{plot}
\alias{print}
\alias{plot,its,missing-method}
\alias{print,its-method}

\title{Display Methods for Irregular Time-Series Objects}
\description{
  Display methods for objects of class \code{"its"}.
}

\section{Usage}{
plot(x,y,colvec=1:ncol(x),type="l",ltypvec=1,lwdvec=1,
leg=FALSE,lab=FALSE,yrange,format,at,interp=c("linear","none"),...)
print(x,...)
}

\section{Arguments}{
\describe{
  \item{x}{an object of class \code{"its"}}
  \item{y}{missing}
  \item{type}{plot type, "l" for line, "p" for point, "b" for both - see \code{\link{par}}.}
  \item{colvec,ltypvec,lwdvec}{vectors of colour codes, line types, and line widths: see \code{\link{par}}.}
  \item{leg}{logical flag to display legend; uses \code{labcurve} in package \code{Hmisc} for auto-position.}
  \item{lab}{logical flag to display labels; uses \code{labcurve} in package \code{Hmisc} for auto-position.}
  \item{yrange}{ordinate range for display.}
  \item{format}{a formatting string, see \code{\link{format.POSIXct}}, for the axis dates}
  \item{at}{a vector of POSIX dates defining tickmark locations on axis: see \code{\link{axis.POSIXct}}}
  \item{interp}{a flag, indicating for plot of type line, how NA vallues are interpolated}
  \item{\dots}{further arguments passed to or from other methods:
    for \code{plot} passed to \code{\link{plot}}.;
    for \code{print} passed to \code{\link{print.default}}}
    }
}
\details{

\code{plot} is the method for plotting irregular time-series objects.
All series are displayed on a single set of axes, by default using different
colours, linetypes, and widths.  If the vectors defining these attributes are 
short, they are cycled.  \code{lab} and \code{leg} are alternatives for labelling 
the curves - these are located using function \code{labcurve()} from package 
Hmisc on CRAN.

\code{print} is the method for printing irregular time-series objects.
The format for the dates is determined at the time the 'its' object is created.

}

\value{

The methods are called for their side-effects.

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
b <- newIts(1:60,ncol=3)
plot(b,colvec=c(1,7),lwdvec=1:2,ltypvec=1:2,lab=TRUE)
print(b)
as.its(matrix(1:60,20,3))
}
