#' @title downloadTD3505
#' 
#' @description
#' \code{downloadTD3505} Boo!
#' 
#' The function is designed to perform basic checks to make sure that 
#' the data are valid (e.g. WBAN and USAF id's match \url{http://www1.ncdc.noaa.gov/pub/data/noaa/isd-history.txt})
#' 
#' @export


downloadTD3505 <- function (rmetObj, ...) {
  
  print("Checking if files have been downloaded")
  print(rmetObj$td3505_noaa)
  
  loc_years <- locYears(rmetObj)
  
  #UTC timezone
  if(rmetObj$surf_UTC < 0){
    lapply(seq_along(loc_years), function(i) {
      if(length(rmetObj$td3505[[i]])>1){
        sourceFile <- rmetObj$td3505[[i]][[1]]
        fileOut<-readLines(con=gzcon(url(sourceFile)))
        
        sourceFile2 <- rmetObj$td3505[[i]][[2]]
        fileOut2 <- readLines(con=gzcon(url(sourceFile2)))
        
        UTC_endDate <- as.numeric(format(rmetObj$end_Date, "%Y%m%d%H%M", tz = "GMT"))
        UTC_endYear <- as.numeric(paste0(as.numeric(loc_years[[i]]) + 1, "01","01", sprintf("%02.0f", -rmetObj$surf_UTC), "00"))
        
        UTC_startDate <- as.numeric(format(rmetObj$start_Date, "%Y%m%d%H%M", tz = "GMT"))
        UTC_startYear <- as.numeric(paste0(as.numeric(loc_years[[i]]), "01","01", sprintf("%02.0f", -rmetObj$surf_UTC), "00"))
        
        indexDate <- ifelse(UTC_endDate < UTC_endYear, UTC_endDate, UTC_endYear)
        #indexDate <- indexDate + 0000000100
        print(as.character(indexDate))
        indX <-  as.numeric(substring(fileOut2, 16,27)) <= indexDate
     
        fileOut2 <-fileOut2[indX]
        fileOut <- c(fileOut, fileOut2)
        
        indexDate <- ifelse(UTC_startDate > UTC_startYear, UTC_startDate, UTC_startYear)
        indX <-  as.numeric(substring(fileOut, 16,27)) >= indexDate
        fileOut <- fileOut[indX]

        station_ID <- substr(fileOut[[1]], 5,15)        
        yearDir <- paste(rmetObj$project_Dir, loc_years[[i]], sep="/")
        if(!dir.exists(yearDir)) dir.create(yearDir)
        destFile <- paste0(yearDir,"/","S",station_ID,"_",loc_years[[i]], ".ISH")
        write(fileOut, file=destFile)
      }else{
        sourceFile <- rmetObj$td3505[[i]][[1]]
        fileOut<-readLines(con=gzcon(url(sourceFile)))
        station_ID <- substr(fileOut[[1]], 5,15)  
        
        UTC_endDate <- as.numeric(format(rmetObj$end_Date, "%Y%m%d%H%M", tz = "GMT"))
        UTC_endYear <- as.numeric(paste0(as.numeric(loc_years[[i]]) + 1, "01","01", sprintf("%02.0f", -rmetObj$surf_UTC), "00"))
        
        indexDate <- ifelse(UTC_endDate < UTC_endYear, UTC_endDate, UTC_endYear)
        indX <-  as.numeric(substring(fileOut, 16,27)) <= indexDate
        
        yearDir <- paste(rmetObj$project_Dir, loc_years[[i]], sep="/")
        if(!dir.exists(yearDir)) dir.create(yearDir)
        destFile <- paste0(yearDir,"/","S",station_ID,"_",loc_years[[i]], ".ISH")
        write(fileOut, file=destFile)
  }
      }
  )
    }
    
  return(NULL)
}

