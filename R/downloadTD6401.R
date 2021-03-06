#' @title downloadTD6401
#' 
#' @description
#' \code{downloadTD6401} Boo!
#' 
#' The function is designed to perform basic checks to make sure that 
#' the data are valid (e.g. WBAN and USAF id's match \url{http://www1.ncdc.noaa.gov/pub/data/noaa/isd-history.txt})
#' 
#' @export


downloadTD6401 <- function (rmetObj, ...) {
  
  print("Checking if files have been downloaded")
  print(rmetObj$td6401_noaa)
  
  loc_years <- names(rmetObj$td6401_noaa)
  
    lapply(seq_along(loc_years), function(i) {
      destDir <- paste(rmetObj$project_Dir, loc_years[[i]], sep="/")
      
        lapply(seq_along(rmetObj$td6401_noaa[[i]]), function(j){
          destFile <- paste(destDir, gsub("^.*/", "", 
                                          rmetObj$td6401_noaa[[i]][[j]]), sep="/")
          download.file(rmetObj$td6401[[i]][[j]], destFile)
          
        })
        
    })
          
        
  return(NULL)
}

