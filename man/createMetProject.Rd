% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/createMetProject.R
\name{createMetProject}
\alias{createMetProject}
\title{createMetProject}
\usage{
createMetProject(project_Name, project_Dir, start_Date, end_Date, surf_WBAN,
  surf_USAF, surf_Call, surf_Latitude, surf_Longitude, surf_Elevation,
  surf_AnenometerHeight, surf_UTC, ifg, ua_WMO, ua_UTC, ua_Latitude,
  ua_Longitude, lc_File, lc_Type, imp_File = NULL, imp_Type = NULL,
  cnpy_File = NULL, cnpy_Type = NULL, as_Snow, as_Arid, as_Moisture,
  as_Airport, as_Winter_NS, as_Winter_WS, as_Spring, as_Summer, as_Autumn,
  as_nsector = 12, as_radius = 1)
}
\description{
\code{createMetProject} Creates basic aermet project, specifying 
the directory, surface station (surf), onsite station (on), upper air (ua) station,
landuse data, start date and ending date.

The function is designed to perform basic checks to make sure that 
the data are valid (e.g. WBAN and USAF id's match \url{http://www1.ncdc.noaa.gov/pub/data/noaa/isd-history.txt})
}

