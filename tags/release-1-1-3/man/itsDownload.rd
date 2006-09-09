\keyword{ts}
\name{priceIts}
\alias{priceIts}
\title{Download Historical Finance Data}
\description{
  Download historical financial data from a given data provider over
  the WWW.
}
\usage{
priceIts(instruments = "^gdaxi", start, end, 
                quote = c("Open","High", "Low", "Close"), 
                provider = "yahoo", method = "auto", 
                origin = "1899-12-30", compression = "d", quiet=TRUE)
                
}
\arguments{
  \item{instruments}{a character string giving the name of the quote
    symbol to download.  See the web page of the data provider for
    information about the available quote symbols.}
  \item{start}{an R object specifying the date of the start of the
    period to download.  This must be in a form which is recognized by
    \code{\link{as.POSIXct}}, which includes R POSIX date/time objects,
    objects of class \code{"date"} (from package \code{date}) and
    \code{"chron"} and \code{"dates"} (from package \code{chron}), and
    character strings representing dates in ISO 8601 format.  Defaults
    to 1992-01-02.}
  \item{end}{an R object specifying the end of the download period, see
    above.  Defaults to yesterday.}
  \item{quote}{a character string or vector indicating whether to
    download opening, high, low, or closing quotes, or volume.  For the
    default provider, this can be specified as \code{"Open"},
    \code{"High"}, \code{"Low"}, \code{"Close"}, and \code{"Volume"},
    respectively.  Abbreviations are allowed.}
  \item{provider}{a character string with the name of the data
    provider.  Currently, only \code{"yahoo"} is implemented.  See
    \url{http://quote.yahoo.com/} for more information.}
  \item{method}{tool to be used for downloading the data.  See
    \code{\link{download.file}} for the available download methods.}
  \item{origin}{an R object specifying the origin of the Julian dates, see
    above.  Defaults to 1899-12-30 (Popular spreadsheet programs
    internally also use Julian dates with this origin).}
  \item{quiet}{a flag to suppress output}
  \item{compression}{Governs the granularity of the retrieved data;
    "d" for daily, "w" for weekly or "m" for monthly. Defaults to "d".} 
}
\value{
  An \code{"its"} object with the requested data
}

\details{
This function is a direct copy from package \code{tseries}, and
all credit must go to the author of that package.
}

\author{A. Trapletti [*not* responsible for errors, adapted from his original idea by Giles Heywood]}

\seealso{
  \code{\link{ts}},
  \code{\link{as.POSIXct}},
  \code{\link{download.file}};
  \url{http://quote.yahoo.com/} 
}
\examples{
\dontrun{
x1 <- priceIts(instrument = c("^ftse"), start = "1998-01-01",
                    quote = "Close")
x2 <- priceIts(instrument = c("^gdax"), start = "1998-01-01",
                    quote = "Close")
x <- union(x1,x2)
names(x) <- c("FTSE","DAX")
plot(x,lab=TRUE)
}
}
