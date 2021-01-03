UserLib=Sys.getenv("R_LIBS_USER")
dir.create(UserLib, recursive=TRUE)
install.packages(c("testthat", "raster", "rgdal"), lib=UserLib, repos="https://cloud.r-project.org") 
