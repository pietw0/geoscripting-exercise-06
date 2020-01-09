# Exercise 4: Introduction to raster

## Detect active wildfires and the extent of fire damage in Landsat imagery

Wildfires have been a hot topic over the last years, with large forested areas being affected. The area of Butte County, Northern California, was devastated by a wildfire called [Camp Fire](https://en.wikipedia.org/wiki/Camp_Fire_(2018)) that started on November 8th 2018. The Camp Fire was the deadliest and most destructive wildfire in California’s history, and lasted until after 16th November 2018.

For more than a decade, satellite remote sensing *active fire data* have been extensively used to inform fire management systems. It can aid in fire containment and suppression, and for assessment of fire-affected areas that will need stabilization and restoration efforts. 

### Your Task
Design a processing chain for detecting **active fires** using freely available Landsat-8 and Landsat-7 images, and provide information about the temperature of these fires.

* The active fires can be detected using the following formula using Surface Reflectance in the specified spectral channels:

<p align="center">
  <img src="https://github.com/geoscripting-innovation/Exercise4-solution/blob/master/images/Formula_active_fire.png"
</p> 

where ρi is reflectance of band that has 2080-2350 μm; ρj is reflectance of band that has 760-900 μm. 

* The temperature of the detected active fires can be extracted from the Surface Temperature product.

### Data
* The Landsat can be found [here](https://www.dropbox.com/sh/ldetgkuffwmky0z/AABuINXJUIS6ZXYIVYOcx2qna?dl=1).
* There are Landsat Surface Reflectance scenes of 4 dates: 
  * start of the fire - November, 
  * end of the fire – November,
  * month before the fire – October *, 
  * month after the fire – December *
  
****only needed for the Extra task***

* There are 2 Landsat Surface Temperature images:
  * start of the fire – November
  * end of the fire – November

* Use the product guide of [Landsat 8](https://landsat.usgs.gov/sites/default/files/documents/si_product_guide.pdf) (see Section 5, page 13) and [Landsat 7](https://prd-wret.s3-us-west-2.amazonaws.com/assets/palladium/production/atoms/files/LSDS-1370_L4-7_SurfaceReflectance-LEDAPS_ProductGuide-v2.pdf)(see Section 4, page 8 ) to figure out the dates of the Landsat scenes.

* Use [this overview](https://www.usgs.gov/faqs/what-are-best-landsat-spectral-bands-use-my-research?qt-news_science_products=0#qt-news_science_products) to find the correct bands for the fire detection area for each sensor.


### Requirements
*	The data should be downloaded in your script, and saved in a folder called `data`, also created in your script. As such, there should be no `data` folder in your Git repository.

*	All output should be saved in a folder called `output`, created in your script. As such, there should be no `output` folder in your Git repository.


*	Visualize the two scenes from November to become familiar with them. Plot them in RGB. Pay attention to correctly identifying which [band is which](https://www.usgs.gov/faqs/what-are-best-landsat-spectral-bands-use-my-research?qt-news_science_products=0#qt-news_science_products). Have a look at the `stretch` parameter. Save the two images separately in output folder as `$FOLDERNAME$.png`, where `$FOLDERNAME$` is the name of the scene folder (i.e. `LC08044322018.......png`).

*	Create a function called `detectFires`, in a file called `detectFires.R` in the `R` folder. It should calculate active fires using the above formula, for both the start and end image. You will source and use this function in your `main.R`.

*	Plot the active fires at both moments in one map, with a title and legend indicating the date of the fires. Save it as `Active_fires_California.png` in the `output` folder.

*	Calculate the average and maximum temperature (in Celsius) of the active fires for each moment using the Surface Temperature images. Assign them to the following variable names: `T_start_mean`, `T_start_max`, `T_end_mean`, `T_end_max`.


### Hints


*	Be careful with reading raster layers, check intermediate results (`fire_start[[1]]` might not be `sr_band1`, as you expect).

*	When creating a map, the title and the legend of the plot are key to understanding the purpose of the map, without leaving room for interpretation. 
    * Make sure you plot your output image with a legend for categorical data ([a simple example](https://biologyforfun.wordpress.com/2013/03/11/taking-control-of-the-legend-in-raster-in-r/) 
    * Label the elements of the legend appropriately
    * Add a title to the plot with details about the purpose of the map   
    * If the visualization is behaving strange, use `dev.off()` to clear the plot memory
    * ***Extra***: add the area of the fire to the plot title, calculated using the raster resolution and fire pixel count
 
* The Surface Temperature products have a different projection and extent than the Surface Reflectance product. Use the functions `projectRaster` and `crop`, to be able to calculate the temperatures for the active fires. 

* When calculating the temperature in Celsius have a look at the [Surface Temperature product guide](https://prd-wret.s3-us-west-2.amazonaws.com/assets/palladium/production/atoms/files/LSDS-1330-LandsatSurfaceTemperature_ProductGuide-v2.pdf)(page 9) to understand the pixel values. *Extra tip*: use `na.rm = True`


### Extra
***Only attempt the extra if you finished and tested the above without errors***

As a extra exercise, calculate the size of the area affected by the fire using the Landsat scenes from October and December and the severity. You can use the Normalized Burn Ratio (NBR) index, which is calculated using the following formula:

<p align="center">
  <img src="https://github.com/geoscripting-innovation/Exercise4-solution/blob/master/images/Formula_NBR.png"
</p> 

The formula is similar to a normalized difference vegetation index (NDVI), except that it uses near-infrared (NIR) and shortwave-infrared (SWIR) portions of the electromagnetic spectrum. By comparing the NBR values from before and after the fire, we obtain information about the extent and severity of the fire event. To calculate the difference NBR, you subtract the post-fire NBR raster from the pre-fire NBR raster as follows:

<p align="center">
  <img src="https://github.com/geoscripting-innovation/Exercise4-solution/blob/master/images/Formula_delta_NBR.png"
</p> 


* Use the Images acquired before and after the fire event to calculate the difference NBR, and classify the severity of the fire as follows:

|ΔNBR	|Burn Severity|
|-----|-------------|
|< -0.25 	|High post-fire regrowth| 
|-0.25 to -0.1 	|Low post-fire regrowth| 
|-0.1 to +0.1 	|Unburned| 
|0.1 to 0.27 	|Low-severity burn| 
|0.27 to 0.66 	|Moderate-severity burn| 
|> 0.66 	|High-severity burn| 

*NOTE: your min an max values for NBR may be slightly different from the table shown above! If you have a smaller min value (< -0.7) or you have a largest max value (>1.5) you can set those values to NA.*

* Plot a map showcasing the aftermath of the fire. Save it as in the output folder as `Camp_fire_severity.png`. 

***Tip***: If you’re in a hurry to finish, here are some nice colours for this final map `col=c("#81a80c","#d0eb7f","#dddedc","#ffff00","#ffbf00","#ff0000")`



