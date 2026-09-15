### Exercise 6
### Koen and Piet
### Sources:
### -> https://stackoverflow.com/questions/7144118/how-can-i-save-a-plot-as-an-image-on-the-disk

### necessary libraries
library(sf)
library(terra)

# what url is used
data_url <- 'https://github.com/GeoScripting-WUR/IntroToRaster/releases/download/landsat-data/Geoscripting_Exercise_4.zip'

# create data and output directory, download zip, and unzip the files
if (!dir.exists("data")) {
  dir.create("data") 
}
if (!dir.exists("output")) {
  dir.create("output")
}
if (!file.exists("data/camp_fire.zip")) {
  download.file(url = data_url, destfile = 'data/camp_fire.zip')
  unzip(zipfile = 'data/camp_fire.zip', exdir = 'data')
}

# make a filepath for the folder of november 8
nov8 <- file.path('data/LC080440322018110801T1-SC20190925130645')
list.files(nov8)
# create a (SpatRaster) variable of the bands of november 8
nov8_bands <- rast(list.files(path = nov8, full.names = TRUE))
nov8_bands
# plot the rgb image and save it in the output folder
png(filename = "output/LC080440322018110801T1-SC20190925130645.png", 
    width = 800, height = 500)
plotRGB(nov8_bands, 7, 6, 5, stretch = "lin")
dev.off()

# make a filepath for the folder of november 16
nov16 <- file.path('data/LE070440322018111601T1-SC20191001153746')
list.files(nov16)
# create a (SpatRaster) variable of the bands of november 16
nov16_bands <- rast(list.files(path = nov16, full.names = TRUE))
nov16_bands
# plot the rgb image and save it in the output folder
png(filename = "output/LE070440322018111601T1-SC20191001153746.png", 
    width = 800, height = 500)
plotRGB(nov16_bands, 6, 5, 4, stretch = "lin")
dev.off()
