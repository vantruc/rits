\name{its-class}
\docType{class}
\alias{its-class}
\alias{Arith,its,its-method}
\alias{Arith,its,numeric-method}
\alias{Arith,numeric,its-method}
\alias{[,its-method}
\alias{[<-,its,ANY,ANY,its-method}
\alias{coerce,its,data.frame-method}
\alias{core,its-method}
\alias{core<-,its,matrix-method}
\alias{cumsum,its-method}
\alias{dates,its-method}
\alias{dates<-,its,POSIXt-method}
\alias{diff,its-method}
\alias{end,its-method}
\alias{intersect,its,its-method}
\alias{intersect,its,NULL-method}
\alias{intersect,NULL,its-method}
\alias{names,its-method}
\alias{names<-,its,character-method}
\alias{plot,its,missing-method}
\alias{print,its-method}
\alias{start,its-method}
\alias{summary,its-method}
\alias{union,its,its-method}
\alias{union,its,NULL-method}
\alias{union,NULL,its-method}

\title{Class "its" Irregularly Spaced Time-Series }
\description{
  S4 class implementation of irregularly spaced time seires.
  The class implements Arith methods using date matching,
  union, intersection, and other time series methods.
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("its", ...)}.
	 ~~ describe objects here ~~ 
}
\section{Slots}{
	 \describe{
    \item{\code{.Data}:}{Object of class \code{"matrix"} the data
      portion of the time series }
    \item{\code{dates}:}{Object of class \code{"POSIXt"} the date vector
    portion of the time series }
  }
}
\section{Extends}{
Class \code{"\linkS4class{matrix}"}, from data part.
Class \code{"\linkS4class{structure}"}, by class "matrix", distance 2.
Class \code{"\linkS4class{array}"}, by class "matrix", distance 2.
Class \code{"\linkS4class{vector}"}, by class "matrix", distance 3, with explicit coerce.
Class \code{"\linkS4class{vector}"}, by class "matrix", distance 4, with explicit coerce.
}
\section{Methods}{
  \describe{
    \item{Arith}{\code{signature(e1 = "its", e2 = "its")}: method for
      Arith of its and its  }
    \item{Arith}{\code{signature(e1 = "its", e2 = "numeric")}: method
      for arith of its and numeric }
    \item{Arith}{\code{signature(e1 = "numeric", e2 = "its")}: method
      for arith of numeric and its }
    \item{[}{\code{signature(x = "its")}: subset operator for its }
    \item{[<-}{\code{signature(x = "its", i = "ANY", j = "ANY", value =
        "its")}: subset assignment operator for its }
    \item{coerce}{\code{signature(from = "its", to = "data.frame")}:
      coerce its to data.frame }
    \item{core}{\code{signature(x = "its")}: extract numeric portion of its }
    \item{core<-}{\code{signature(x = "its", value = "matrix")}:
      assignment to numeric portion of its }
    \item{cumsum}{\code{signature(x = "its")}: cumulative sum of its series }
    \item{dates}{\code{signature(x = "its")}: extract dates vector from
      its object }
    \item{dates<-}{\code{signature(x = "its", value = "POSIXt")}: assign
    dates into its object }
    \item{diff}{\code{signature(x = "its")}: difference function for its }
    \item{end}{\code{signature(x = "its")}: ... }
    \item{intersect}{\code{signature(x = "its", y = "its")}: take date
      intersection of its object }
    \item{intersect}{\code{signature(x = "its", y = "NULL")}: ... }
    \item{intersect}{\code{signature(x = "NULL", y = "its")}: ... }
    \item{names}{\code{signature(x = "its")}: extract column names from
      its object }
    \item{names<-}{\code{signature(x = "its", value = "character")}:
      assign names into its object }
    \item{plot}{\code{signature(x = "its", y = "missing")}: plot an its object }
    \item{print}{\code{signature(x = "its")}: print an its object }
    \item{start}{\code{signature(x = "its")}: ... }
    \item{summary}{\code{signature(object = "its")}: summary of an its object }
    \item{union}{\code{signature(x = "its", y = "its")}: combine its objects }
    \item{union}{\code{signature(x = "its", y = "NULL")}: ... }
    \item{union}{\code{signature(x = "NULL", y = "its")}: ... }
	 }
}
\references{ http://code.google.com/p/rits }
\author{ Whit Armstrong }
\note{ This package was written by Giles Heywood.  }
\examples{
showClass("its")
}
\keyword{classes}
