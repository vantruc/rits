testIts <- function(graph=TRUE,New=TRUE)
{
addDimnames <- function(mat)
    {
    if(is.null(dimnames(mat))) {dimnames(mat) <- list(NULL,NULL)}
    if(is.null(dimnames(mat)[[1]])&(nrow(mat)>0)) {dimnames(mat)[[1]] <- 1:nrow(mat)}
    if(is.null(dimnames(mat)[[2]])&(ncol(mat)>0)) {dimnames(mat)[[2]] <- 1:ncol(mat)}
    return(mat)
    }
test <- function(x){if(!identical(x,TRUE))stop()}
#test procedure for its
mytimes <- seq.POSIXt(from=Sys.time(),by=24*60*60,length.out=10)
attr(mytimes,"tzone") <- ""
mat <- addDimnames(matrix(1:30,10,3))
dimnames(mat)[[2]] <- c("A","B","C")
its.format("%Y-%m-%d %X")
x <- its(mat,mytimes)
moretimes <- seq.POSIXt(from=Sys.time()+1,by=24*60*60,length.out=11)
more <- addDimnames(matrix(1:33,11,3))
dimnames(more)[[2]] <- c("A","B","C")
x2 <- its(more,moretimes)
#its-arith**********************************************************
#arith-methods------------------------------------------------------
y1 <- x[,1]+x[,2]
y2 <- its(x@.Data[,1,drop=FALSE]+x@.Data[,2,drop=FALSE],mytimes)
test(all.equal(y1@.Data,y2@.Data))
test(all.equal(y1@dates,y2@dates))
y1 <- x[,1]+x[,2]*pi
y2 <- its(x@.Data[,1,drop=FALSE]+x@.Data[,2,drop=FALSE]*pi,mytimes)
test(all.equal(y1@.Data,y2@.Data))
test(all.equal(y1@dates,y2@dates))
y1 <- x[,1]+pi
y2 <- its(x@.Data[,1,drop=FALSE]+pi,mytimes)
test(all.equal(y1@.Data,y2@.Data))
test(all.equal(y1@dates,y2@dates))
y3 <- its(mat,mytimes+24*60*60)

# changed in version 1.0.4
# the intersection of the dates is now taken
#ermsg <- try(x+y3,silent=TRUE)
#test(ermsg=="Error in x + y3 : dates must match\n")
#ermsg <- try(x+x2,silent=TRUE)
#test(ermsg=="Error in x + x2 : dates must match\n")


#extractor**********************************************************
y1 <- x[,1,dates=dates(x)[1:5]]
y2 <- x[1:5,1]
y3 <- y1+y2
test(all(dates(y1)==dates(x)[1:5]))
test(all(core(y1)==core(x)[1:5,1]))
#names**************************************************************
test(all(names(x)==dimnames(core(x))[[2]]))
y1 <- x
names(y1) <- letters[1:ncol(y1)]
test(all(names(y1)==letters[1:ncol(y1)]))
#dates**************************************************************
test(all(dates(x)==x@dates))
y1 <- x
dates(y1) <- moretimes[1:nrow(y1)]
test(all(dates(y1)==moretimes[1:nrow(y1)]))
#core***************************************************************
test(all(core(x)==x@.Data))
y1 <- x
core(x) <- addDimnames(matrix(101:130,10,3))
test(all(core(x)==addDimnames(matrix(101:130,10,3))))
#its-cumdif*********************************************************
#cumsum-method------------------------------------------------------
foo <- cumsum(x)
test(all.equal(foo@.Data[,1],cumsum(x@.Data[,1])))
test(all.equal(foo@dates,mytimes))
#diff-method--------------------------------------------------------
foo <- diff(cumsum(x))
bar <- alignedIts(foo,x,print=FALSE)
test(all.equal(bar[[1]],bar[[2]]))
#its-def************************************************************
#-Functions-
#is.its-function----------------------------------------------------
test(is.its(x))
test(!is.its(x@.Data))
test(!is.its(x@dates))
#as.its-function----------------------------------------------------
foo <- as.numeric(mat[,1,drop=F])
class(foo) <- c("POSIXt","POSIXct")
bar <- its(mat[,-1],foo)
waz <- as.its(mat)
test(all.equal(bar,waz))
#its-function-------------------------------------------------------
x <- its(mat,mytimes)
test(all.equal(x@dates,mytimes))
test(all.equal(x@.Data/mat,x@.Data/x@.Data))
#parameters
years <- 100:105
hoursecs <- 60*60
regdaysecs <- 24*hoursecs
monthdays <- c(28,29,30,31)
monthsecs <- c(monthdays*regdaysecs,monthdays*regdaysecs-hoursecs,monthdays*regdaysecs+hoursecs)
weeksecs <- 7*regdaysecs #+hoursecs*c(-1,0,1)
daysecs <-  regdaysecs+hoursecs*c(-1,0,1)
its.format("%Y-%m-%d")

#***newIts 
#newIts-from
if(as.numeric(R.Version()$major)*1000+as.numeric(R.Version()$minor)*10>=1080 & New)
    {

    mystarts <- c("2003-01-01","2002-12-31","2003-11-17","2004-10-27")
    myends <- c("2003-02-01","2003-12-31","2004-12-17","2004-11-01")

    for(ddd in mystarts)
        {
        TEST <- newIts(start=ddd)
        test(start(TEST)==ddd)
        }
    #newIts-to
    for(ddd in myends)
        {
        TEST <- newIts(start="2002-11-17",end=ddd)
        test(end(TEST)==ddd)
        }
    for(i in 1:3)
        {
        TEST <- newIts(start=mystarts[i],end=myends[i])
        test((start(TEST)==mystarts[i])&(end(TEST)==myends[i]))
        }

    #newIts-by
    TEST <- newIts(end="2005-12-31")
    test(all(diff(as.numeric(TEST@dates))%in%daysecs))
    TEST <- newIts(start="2003-10-1",end="2010-12-1",by="month")
    test(all(diff(as.numeric(TEST@dates))%in%monthsecs))
    TEST <- newIts(end="2010-12-31",by="week")  #(n.b. no DSTweek available)
    test(all(diff(as.numeric(TEST@dates))%in%weeksecs))


    #newIts-ncol
    ncol(newIts(end="2005-12-31",ncol=5))==5

    #***extractIts permutations
    #-weekday
    weekDaySelection <- c(0,6)
    nowt <- newIts(extract=TRUE,weekday=TRUE,select=weekDaySelection)
    test(length(nowt)==0)
    weekDaySelection <- 1:5
    TEST1 <- newIts(extract=TRUE,weekday=TRUE)
    TEST2 <- newIts(extract=TRUE,weekday=TRUE,select=weekDaySelection)
    TEST3 <- newIts()
    test(length(TEST1)>0)
    test(length(TEST2)==length(TEST1))
    test(length(TEST3)>length(TEST2))
    test(all(as.POSIXlt(TEST1@dates)$wday%in%weekDaySelection))
    test(all(weekDaySelection%in%as.POSIXlt(TEST1@dates)$wday))
    #-find ("all","last","first")
    test(identical(newIts(extract=TRUE,select=0:6,period="week"),newIts()))
    test(identical(newIts(extract=TRUE,select=0:6,period="week",find="all"),newIts()))
    TEST1 <- newIts(extract=TRUE,period="week",find="first",partial=FALSE)
    TEST2 <- newIts(extract=TRUE,select=0,period="week")
    test(all(TEST1%in%TEST2))
    TEST1 <- newIts(extract=TRUE,period="week",find="last",partial=FALSE)
    TEST2 <- newIts(extract=TRUE,select=6,period="week")
    test(all(TEST1%in%TEST2))
    TEST1 <- newIts(weekday=TRUE,extract=TRUE,period="week",find="first",partial=FALSE)
    TEST2 <- newIts(weekday=TRUE,extract=TRUE,select=1,period="week")
    test(all(TEST1%in%TEST2))
    TEST1 <- newIts(weekday=TRUE,extract=TRUE,period="week",find="last",partial=FALSE)
    TEST2 <- newIts(weekday=TRUE,extract=TRUE,select=5,period="week")
    test(all(TEST1%in%TEST2))
    #-period
    test(all(as.POSIXlt(newIts(extract=TRUE,period="week",find="first",partial=FALSE)@dates)$wday==0))
    test(all(as.POSIXlt(newIts(extract=TRUE,period="week",find="last",partial=FALSE)@dates)$wday==6))
    test(all(as.POSIXlt(newIts(extract=TRUE,period="month",find="first",partial=FALSE)@dates)$mday==1))
    test(all(as.POSIXlt(newIts(extract=TRUE,period="month",find="last",partial=FALSE)@dates)$mday%in%28:31))
    test(identical(newIts(extract=TRUE,period="week",select=0:6),newIts()))
    test(identical(newIts(extract=TRUE,period="month",select=1:31),newIts()))
    #-partials
    TEST <- newIts(start="2003-11-18")
    TEST1 <- newIts(start="2003-11-18",period="week",find="first",extract=TRUE,partial=TRUE)
    TEST2 <- newIts(start="2003-11-18",period="week",find="first",extract=TRUE,partial=FALSE)
    TEST@dates[1]==TEST1@dates[1]
    test((nrow(TEST1)-1)==nrow(TEST2))
    #-select
    for(i in 0:6)
        {
        TEST <- newIts(extract=TRUE,period="week",select=i)
        test(all(as.POSIXlt(TEST@dates)$wday==i))
        }
    for(i in 30:31)
        {
        TEST <- newIts(extract=TRUE,period="month",select=i)
        test(all(as.POSIXlt(TEST@dates)$mday==i))
        }
    }
#its-disp***********************************************************
#plot-method--------------------------------------------------------
#create 5 sinusoids differing in phase by pi/6
its.format("%Y-%m-%d %X")
if(graph)
    {
    sintimes <- seq.POSIXt(from=Sys.time(),by=24*60*60,length.out=100)
    sintimes.num <- as.numeric(sintimes)
    sinmat <- addDimnames(matrix(NA,100,5))
    for(j in 1:5){sinmat[,j] <- sin((6*pi*sintimes.num/(sintimes.num[100]-sintimes.num[1]))-j*pi/6)}
    dimnames(sinmat)[[2]] <- LETTERS[1:5]
    sinx <- its(sinmat,sintimes)
    par(mfrow=c(3,3))
    #line,point
    plot(sinx,type="p",main="Point")
    plot(sinx,type="l",main="Line")
    plot(sinx,type="b",main="Both")
    #colour, width, type cycling
    plot(sinx,lwdvec=1:3,main="Width")
    plot(sinx,ltypvec=1:3,main="Type")
    plot(sinx,colvec=c(1,2,7),main="Colour")
    #axis
    plot(sinx,format="%B",main="Label")
    plot(sinx,at=sintimes[c(1,100)],main="Position")
    #NA handling
    sinx[10:20,] <- sinx[10:20,]*NA
    sinx[,2] <- sinx[,2]*NA
    plot(sinx,interp="n",main="NAs")
    }
#print-method-------------------------------------------------------
print(x)
#its-file***********************************************************
#writecsvIts-function-----------------------------------------------
file <- tempfile()
writecsvIts(x,file,col.names=FALSE)
writecsvIts(x,file,row.names=FALSE,col.names=FALSE)
writecsvIts(x,file)
#readcsvIts-function------------------------------------------------
foo <- its(readcsvIts(file))
y <- its(x)
test(all.equal(foo,y))
test(identical(as.numeric(foo@.Data),as.numeric(y@.Data)))
test(identical(foo@dates,y@dates))
test(identical(dimnames(foo),dimnames(y)))
#its-fin************************************************************
#accrueIts-function-------------------------------------------------
test(all.equal(accrueIts(x)-lagIts(x)[-1,]/(365),accrueIts(x)*0))
#its-info***********************************************************
#summary-method-----------------------------------------------------
foo <- summary(x)
test(all.equal(foo[1,],seq(1,21,10)))
test(all.equal(foo[6,],seq(10,30,10)))
test(all.equal(foo[8,],rep(10,3)))
#start-method-------------------------------------------------------
test(identical(start(x,format="%Y-%m-%d-%X"),format.POSIXct(mytimes[1],format="%Y-%m-%d-%X")))
test(identical(start(x[2:nrow(x),],format="%Y-%m-%d-%X"),format.POSIXct(mytimes[2],format="%Y-%m-%d-%X")))
#end -method--------------------------------------------------------
test(identical(end(x,format="%Y-%m-%d %X"),format.POSIXct(mytimes[10],format="%Y-%m-%d %X")))
test(identical(end(x[1:(nrow(x)-1),],format="%Y-%m-%d %X"),format.POSIXct(mytimes[nrow(x)-1],format="%Y-%m-%d %X")))
#its-join***********************************************************
#alignedIts-function---------------------------------------------
isub <- seq(1,9,2)
x <- its(x)
xsub <- x[isub,]
foo <- alignedIts(x,xsub,print=F)

#identical is not working here
test(identical(foo[[1]],xsub))
test(identical(foo[[2]],xsub))

test(identical(foo[[1]]@dates,xsub@dates))
test(identical(core(foo[[1]]),core(xsub)))

#appendIts-function-------------------------------------------------

# these operations change the order of the attributes of the date
# after this, identical can't be used to compare series
# because the attributes order does not match
later <- mytimes+366*24*60*60
over <- mytimes+5*24*60*60


x <- its(mat,mytimes)
xlate <- its(mat,later)
xover <- its(mat,over)
foo <- appendIts(x,xlate)
bar <- appendIts(xlate,x)
test(identical(foo,bar))
test(identical(foo[1:10],x))
# test(identical(foo[11:20],xlate))
test(all.equal(foo[11:20],xlate))
foo <- try(appendIts(x,x[(2:(nrow(x)-1)),],but=FALSE),silent=TRUE)
test(identical(grep("appendor data must extend appendee data",foo)>0,TRUE))
foo <- appendIts(x/x,xover/xover,but=FALSE)
foo <- try(appendIts(x,xover,but=FALSE),silent=TRUE)
test(identical(grep("overlap data does not match",foo)>0,TRUE))
foo <- try(appendIts(x,xover),silent=TRUE)
test(foo=="Error in appendIts(x, xover) : overlap not allowed\n")
dimnames(xlate)[[2]][1] <- "Z"
foo <- try(appendIts(x,xlate),silent=TRUE)
test(foo=="Error in appendIts(x, xlate) : names of the two inputs must match\n")
#10 cases          
#    S1  E1  S2  E2
# 1   1   2   3   4
# 2   1   3   2   4
# 3   1   4   2   3
# 4   2   3   1   4
# 5   2   4   1   3
# 6   3   4   1   2
# 7   1   2   2   2
# 8   1   2   3   3
# 9   2   3   1   1
#10   1   2   1   1
x <- its(mat,mytimes)
# 1   1   2   3   4
x1 <- x[1:4,]
x2 <- x[5:8,]
foo <- appendIts(x1,x2,but=FALSE,matchnames=FALSE)
test(identical(x[1:8,],foo))
foo <- appendIts(x1,x2,but=FALSE,matchnames=TRUE)
test(identical(x[1:8,],foo))
foo <- appendIts(x1,x2,but=TRUE,matchnames=FALSE)
test(identical(x[1:8,],foo))
foo <- appendIts(x1,x2,but=TRUE,matchnames=TRUE)
test(identical(x[1:8,],foo))
# 2   1   3   2   4
x1 <- x[1:4,]
x2 <- x[3:6,]
foo <- appendIts(x1,x2,but=FALSE,matchnames=FALSE)
test(identical(x[1:6,],foo))
foo <- appendIts(x1,x2,but=FALSE,matchnames=TRUE)
test(identical(x[1:6,],foo))
foo <- try(appendIts(x1,x2,but=TRUE,matchnames=FALSE),silent=TRUE)
test(identical(grep("overlap not allowed",foo)>0,TRUE))
foo <- try(appendIts(x1,x2,but=TRUE,matchnames=TRUE),silent=TRUE)
test(identical(grep("overlap not allowed",foo)>0,TRUE))
# 3   1   4   2   3
x1 <- x[1:4,]
x2 <- x[2:3,]
foo <- try(appendIts(x1,x2,but=FALSE,matchnames=FALSE),silent=TRUE)
test(identical(grep("appendor data must extend appendee data",foo)>0,TRUE))
foo <- try(appendIts(x1,x2,but=FALSE,matchnames=TRUE),silent=TRUE)
test(identical(grep("appendor data must extend appendee data",foo)>0,TRUE))
foo <- try(appendIts(x1,x2,but=TRUE,matchnames=FALSE),silent=TRUE)
test(identical(grep("overlap not allowed",foo)>0,TRUE))
foo <- try(appendIts(x1,x2,but=TRUE,matchnames=TRUE),silent=TRUE)
test(identical(grep("overlap not allowed",foo)>0,TRUE))
# 4   2   3   1   4
x1 <- x[2:3,]
x2 <- x[1:4,]
foo <- try(appendIts(x1,x2,but=FALSE,matchnames=FALSE),silent=TRUE)
test(identical(grep("appendor data must extend appendee data",foo)>0,TRUE))
foo <- try(appendIts(x1,x2,but=FALSE,matchnames=TRUE),silent=TRUE)
test(identical(grep("appendor data must extend appendee data",foo)>0,TRUE))
foo <- try(appendIts(x1,x2,but=TRUE,matchnames=FALSE),silent=TRUE)
test(identical(grep("overlap not allowed",foo)>0,TRUE))
foo <- try(appendIts(x1,x2,but=TRUE,matchnames=TRUE),silent=TRUE)
test(identical(grep("overlap not allowed",foo)>0,TRUE))
# 5   2   4   1   3
x1 <- x[2:4,]
x2 <- x[1:3,]
foo <- appendIts(x1,x2,but=FALSE,matchnames=FALSE)
test(identical(x[1:4,],foo))
foo <- appendIts(x1,x2,but=FALSE,matchnames=TRUE)
test(identical(x[1:4,],foo))
foo <- try(appendIts(x1,x2,but=TRUE,matchnames=FALSE),silent=TRUE)
test(identical(grep("overlap not allowed",foo)>0,TRUE))
foo <- try(appendIts(x1,x2,but=TRUE,matchnames=TRUE),silent=TRUE)
test(identical(grep("overlap not allowed",foo)>0,TRUE))
# 6   3   4   1   2
x1 <- x[3:4,]
x2 <- x[1:2,]
foo <- appendIts(x1,x2,but=FALSE,matchnames=FALSE)
test(identical(x[1:4,],foo))
foo <- appendIts(x1,x2,but=FALSE,matchnames=TRUE)
test(identical(x[1:4,],foo))
foo <- appendIts(x1,x2,but=TRUE,matchnames=FALSE)
test(identical(x[1:4,],foo))
foo <- appendIts(x1,x2,but=TRUE,matchnames=TRUE)
test(identical(x[1:4,],foo))
# 7   1   2   2   2
x1 <- x[1:4,]
x2 <- x[4,]
foo <- appendIts(x1,x2,but=FALSE,matchnames=FALSE)
test(identical(x[1:4,],foo))
foo <- appendIts(x1,x2,but=FALSE,matchnames=TRUE)
test(identical(x[1:4,],foo))
foo <- try(appendIts(x1,x2,but=TRUE,matchnames=FALSE),silent=TRUE)
test(identical(grep("overlap not allowed",foo)>0,TRUE))
foo <- try(appendIts(x1,x2,but=TRUE,matchnames=TRUE),silent=TRUE)
test(identical(grep("overlap not allowed",foo)>0,TRUE))
# 8   1   2   3   3
x1 <- x[1:4,]
x2 <- x[5,]
foo <- appendIts(x1,x2,but=FALSE,matchnames=FALSE)
test(identical(x[1:5,],foo))
foo <- appendIts(x1,x2,but=FALSE,matchnames=TRUE)
test(identical(x[1:5,],foo))
foo <- appendIts(x1,x2,but=TRUE,matchnames=FALSE)
test(identical(x[1:5,],foo))
foo <- appendIts(x1,x2,but=TRUE,matchnames=TRUE)
test(identical(x[1:5,],foo))
# 9   2   3   1   1
x1 <- x[2:4,]
x2 <- x[1,]
foo <- appendIts(x1,x2,but=FALSE,matchnames=FALSE)
test(identical(x[1:4,],foo))
foo <- appendIts(x1,x2,but=FALSE,matchnames=TRUE)
test(identical(x[1:4,],foo))
foo <- appendIts(x1,x2,but=TRUE,matchnames=FALSE)
test(identical(x[1:4,],foo))
foo <- appendIts(x1,x2,but=TRUE,matchnames=TRUE)
test(identical(x[1:4,],foo))
#10   1   2   1   1
x1 <- x[2:4,]
x2 <- x[2,]
foo <- appendIts(x1,x2,but=FALSE,matchnames=FALSE)
test(identical(x[2:4,],foo))
foo <- appendIts(x1,x2,but=FALSE,matchnames=TRUE)
test(identical(x[2:4,],foo))
foo <- try(appendIts(x1,x2,but=TRUE,matchnames=FALSE),silent=TRUE)
test(identical(grep("overlap not allowed",foo)>0,TRUE))
foo <- try(appendIts(x1,x2,but=TRUE,matchnames=TRUE),silent=TRUE)
test(identical(grep("overlap not allowed",foo)>0,TRUE))
#union-method-------------------------------------------------------
isub <- seq(1,9,2)
ioth <- setdiff(1:10,isub)
xsub <- x[isub,]
xun <- union(x,xsub)
test(identical(xun[,1:3],x))
test(identical(xun[isub,4:6],xsub))
test(all(is.na(xun[ioth,4:6])))
#intersect-method---------------------------------------------------
xsub <- x[isub,]
xin <- intersect(x,xsub)
test(identical(xin[,1:3],xsub))
test(identical(xin[,4:6],xsub))
#its-lags***********************************************************
#lagIts-function----------------------------------------------------
foo <- lagIts(x)
test(all(foo[-1,]==x[-nrow(x),]))
test(all(foo@dates==x@dates))
#lagdistIts-function------------------------------------------------
foo <- lagdistIts(x[,1],1,3)
test(all.equal(foo[,1],lagIts(x[,1],1)))
test(all.equal(foo[,2],lagIts(x[,1],2)))
test(all.equal(foo[,3],lagIts(x[,1],3)))
test(all.equal(x@dates,foo@dates))
#its-subset*********************************************************
#rangeIts-function--------------------------------------------------
now <- format.POSIXct(Sys.time(),format=its.format())
tomorrow <- format.POSIXct(Sys.time()+24*60*60,format=its.format())
test(identical(appendIts(rangeIts(x,start=now),rangeIts(x,end=now)),x))
test(nrow(rangeIts(x,start=now,end=now))==0)
test(nrow(rangeIts(x,start=now,end=tomorrow))==1)
#[-method-----------------------------------------------------------
i1 <- rep(c(TRUE,FALSE),5)
j1 <- c(TRUE,FALSE,TRUE)
test(all(x[2:8,2:3]==mat[2:8,2:3]))
test(all(x[3,3]==mat[3,3]))
test(all(x[0,0]==mat[0,0]))
test(all(x[-2,]==mat[-2,]))
test(all(x[,-2]==mat[,-2]))
test(all(x[,j1]==mat[,j1]))
test(all(x[,j1]==mat[,j1]))
test(all(x[i1,j1]==mat[i1,j1]))
test(all(mat[c(TRUE,FALSE,TRUE),]==x[c(TRUE,FALSE,TRUE),]))
test(all(mat[,c(TRUE,FALSE)]==x[,c(TRUE,FALSE)]))
mat2 <- mat
x2 <- x
mat2[c(TRUE,FALSE),c(TRUE,FALSE)] <- c(1000,2000)
x2[c(TRUE,FALSE),c(TRUE,FALSE)] <- c(1000,2000)
test(all(mat2==x2))
#its-times**********************************************************
#daysecondIts-function----------------------------------------------
#weekdayIts-function------------------------------------------------
foo <- as.POSIXlt(mytimes)$wday
test(identical((foo>0 & foo<6),weekdayIts(x)))
#collapseIts--------------------------------------------------------
if(as.numeric(R.Version()$major)*100+as.numeric(R.Version()$minor)*10>=1080 & New)
    {
    foo <- newIts(ncol=4,per="w",find="l",extract=T)[1:5,]
    foo[,1] <- c(NA,NA,NA,1,1)
    foo[,2] <- 1
    foo[,4] <- c(NA, 1, 1,1,1)
    dimnames(foo)[[2]] <- c("A","A","B","A")
    test(all.equal(collapseIts(foo),foo[,2:3]))
    foo[5,1] <- 1.01
    bar <- try(collapseIts(foo),silent=TRUE)
    test(bar=="Error in collapseIts(foo) : column data must match in collapse function\n")
    }
#itsPrice***********************************************************
#creat a (static) set of securities
#3 indices, 3 stocks
x <- priceIts()
if(require(Rblp))
{
b <- blpConnect()
yahtkrs <- c("^gdaxi","^ftse","^spx")
blptkrs <- c("dax index","ukx index","spx index")
startdate <- "2004-02-01"
enddate <- "2004-02-10"
yahitemslist <- c("Close","Open")
blpitemslist <- c("LAST_PRICE","PX_OPEN")
for(j in 1:length(yahitemslist))
    {
    yahooPrice <- priceIts(instrument = yahtkrs, 
        start=startdate, 
        end=enddate, 
        quote = yahitemslist[j], 
        provider = "yahoo", 
        method = "auto", 
        origin = "1899-12-30") 
    blpPrice <- NULL
    for(i in 1:length(blptkrs))
        {
         blpPrice <- union(blpPrice,getBLPTimeSeries(b, 
            blpCodes = blptkrs[i], 
            blpItems = blpitemslist[j], 
            currency = "LOC", 
            startDate = as.POSIXct(startdate,its.format()), 
            endDate = as.POSIXct(enddate,its.format()), 
            reqSize = 20))
        }
    class(blpPrice)    
    names(blpPrice) <- blptkrs
    foo <- union(yahooPrice[,1:3],blpPrice[,1:3])
    test(var(as.numeric(core(foo[,1:3]-foo[,4:6])),na.rm=T)==0)
    }
}
#its-utilities******************************************************
###########################################################################################
#fromirtsIts-function------------------------------------------------
#identical(fromirtsIts(irts(x@dates,x)),x)

#locf---------------------------------------------------------------
foo <- x
foo[2:4,] <- NA
test(identical(dates(x),dates(foo)))

#-Utility Methods-
#validity check-----------------------------------------------------
#dates<--method-----------------------------------------------------
#[-method-----------------------------------------------------------

#-Utility Functions-
#addDimnames-function-----------------------------------------------
#gap.its-function---------------------------------------------------
#overlaps.its-function----------------------------------------------
#overlapmatches.its-function----------------------------------------
#namesmatch.its-function--------------------------------------------
#its.format-function------------------------------------------------
#simdates.its-function----------------------------------------------
#***extractDates
    its.format("%Y-%m-%d")
    TEST <- newIts(start="2003-11-17",end="2005-12-25")
    #-select
    test(all((as.numeric(extractIts(TEST,period="week",select=2)@dates)-as.numeric(extractIts(TEST,period="week",select=1)@dates))%in%daysecs))
    #-weekday
    test(all(as.POSIXlt(extractIts(TEST,weekday=TRUE)@dates)$wday
        %in%1:5))
    test(all(as.POSIXlt(extractIts(TEST,weekday=TRUE,find="last")@dates)$wday
        %in%1:5))
    test(all(as.POSIXlt(extractIts(TEST,weekday=TRUE,select=weekDaySelection)@dates)$wday
        %in%weekDaySelection))
    test(all(as.POSIXlt(extractIts(TEST,weekday=TRUE,select=weekDaySelection,period="week",find="last")@dates)$wday==5))
    test(all(as.POSIXlt(extractIts(TEST,weekday=TRUE,select=weekDaySelection,period="week",find="first")@dates)$wday==1))
    #-find
    test(all(as.POSIXlt(extractIts(TEST,weekday=TRUE,period="week",find="first")@dates[-1])$wday==1))
    TESTX <-
     extractIts(TEST[1:(length(TEST@dates)-2)],weekday=TRUE,period="week",find="last")@dates
    test(all(as.POSIXlt(TESTX)$wday[-length(TESTX)]==5))
    #-period
    test(all(as.POSIXlt(extractIts(TEST,weekday=FALSE,period="year",find="first",partial=FALSE)@dates)$yday==0))
    test(all(as.POSIXlt(extractIts(TEST,weekday=FALSE,period="month",find="last",partial=FALSE)@dates)$mday%in%monthdays))
    test(all(as.POSIXlt(extractIts(TEST,weekday=FALSE,period="month",find="first",partial=FALSE)@dates)$mday==1))
    test(all(as.POSIXlt(extractIts(TEST,weekday=FALSE,period="week",find="first",partial=FALSE)@dates)$wday==0))
    test(all(as.POSIXlt(dates(extractIts(newIts(start="2001-12-21",end="2002-01-10")[-10:-11,],find="last",period="week",partial=FALSE)))$wday ==6))
    #firstlast
    test(start(extractIts(TEST,per="y",find="f",firstlast=TRUE))==start(TEST)&&end(extractIts(TEST,,per="y",find="f",firstlast=TRUE))==end(TEST))
    #-select
    test(all((as.numeric(extractIts(TEST,period="week",select=2)@dates)-as.numeric(extractIts(TEST,period="week",select=1)@dates))%in%daysecs))
    test(all(as.POSIXlt(extractIts(TEST,period="week",select=2)@dates)$wday==2))
    test(all(as.POSIXlt(extractIts(TEST,period="week",select=2,weekday=TRUE)@dates)$wday==2))
#
cat(
    paste(sep="",
        "******************************\n* its test suite successful  *\n",
        "* ",
        R.version.string,
        "* ",
        "\n",
        "******************************\n")
    )    
}
#debug(testIts)
require(its)
#require(Rblp)
print(system.time(testIts(New=TRUE,graph=FALSE)))
print(system.time(testIts(New=TRUE,graph=TRUE)))
