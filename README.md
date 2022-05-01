# longitudinal_DEM

Creates a digital elevation model (DEM) following the axis of a centerline.  Developed with the primary purpose to capture numerous cross-sectional profiles along the longitudinal axis of rivers/estuaries.  

# Data Requirements
Centerline coordinates of river: Requires coordinates for centerline transect of a river in Universal Transverse Mercator (UTM) coordinates. This can be created in Google Earth Pro by drawing a path along through the center of river. Must be exported in UTM coordinates or converted to UTM.<br/>
  DEM data: Requires DEM data of the river. x array, y array, and grid of elevation. All in meters

# How to Use
Run function in MATLAB.<br/>
<br/>
Inputs: <br/>
<br/>
DEMx: x data for DEM, (1-dimensional array, not a grid), UTM<br/>
DEMy: y data for DEM (1-dimensional array, not a grid), UTM<br/>
DEMgrid: DEM grid, elevation in meters.<br/>
centerline_x: x coordinates of centerline transect (string), UTM<br/>
centerline_y: y coordinates of centerline transect, UTM<br/>
interval_longidudinal: interval along the centerline of cross-sections, capturing the longitudinal spacing, in meters.<br/>
interval_width: interval along the cross-section where elevations will be identified (i.e., lateral spacing, lines which are perpendicular to the centerline), in meters.<br/>
total_width: total length of cross-section (perpendicular to the centerline), in meters.<br/> 
See Figure 1 and 2 below for image of cross-sectional lines.<br/>
(Note: Inputs can have any projection with consistently spaced x and y coordinates.  Outputs will have the same units as the inputs.  We suggest using UTM). <br/>
<br/>
Outputs:<br/>
<br/>
Contour plot of elevation. See Figure 3 below. <br/>
elev_grid: grid of elevation data, in meters, with axes of new_y-by-new_x.<br/>
new_x: new x array for elev_grid, in meters. <br/>
new_y: new y array for elev_grid, in meters. <br/>
center_location: center location of each cross-section, corresponding to input x-y coordinates.
<br/>
<br/>
<br/>

# Figures

![image](https://user-images.githubusercontent.com/95195098/166154727-779f6b45-5bce-4cfa-b376-d750975aeadd.png) <br/>
Figure 1. Example of an input grid and the methodology of longitudinal_DEM.m. By increasing or decreasing total_width, you can increase or decrease the width of the cross-sectional lines to extend over the width of the river as needed. The cross-sectional lines can be moved closer together or farther apart by decreasing or increasing the interval_width.<br/><br/>
![image](https://user-images.githubusercontent.com/95195098/166154737-9c182bb1-41fe-41df-af3d-790799e45a56.png) <br/>
Figure 2. Zoomed in image of Figure 1, showing the centerline (black) and cross-sectional lines (red) over a river/estuary (Charleston Harbor and Ashley River) <br/><br/>
![image](https://user-images.githubusercontent.com/95195098/166155380-acd0f6c1-d610-460f-82dc-64d04b8c5e8c.png) <br/>
Figure 3. Example outputs. Left figure shows output from example (longitudinal_DEM_example.m found in repository) with downsized DEM data (downsized for uploading purposes). Right figure shows output with full DEM (data not available in example).  
<br/>
<br/>
<br/>
<br/>
# Data References
Cooperative Institute for Research in Environmental Sciences (CIRES) at the University of Colorado, Boulder. 2014: Continuously Updated Digital Elevation Model (CUDEM) - 1/9 Arc-Second Resolution Bathymetric-Topographic Tiles. NOAA National Centers for Environmental Information. https://doi.org/10.25921/ds9v-ky35.
<br/> <br/>
Downloading similar datasets for other coastal regions in the United States can be easily accomplished using the NOAA Data Access Viewer (https://coast.noaa.gov/dataviewer/)

# Authors
Olivia N. Szot and Steven L. Dykstra
