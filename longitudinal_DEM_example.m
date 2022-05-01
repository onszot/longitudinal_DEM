% example code for longitudinal_DEM function
% disclaimer: the DEM data used here has been downsized for uploading purposes 
% so the figure is slightly distorted
% download AshleyDEMshort.mat and centerline_UTM.mat from repository

load AshleyDEMshort.mat % this contains x, y, and grid from DEM, UTM coordinates
DEMx=x2;
DEMy=y2;
DEMgrid=z2;

load centerline_UTM.mat % this contains the coordinates of the centerline in UTM
% Centerline can be created in Google Earth Pro by drawing a path through
% the center of a river (Ashley River in this case).

%figure; plot(centerline_x,centerline_y); % plots river center line

% set preferences of the intervals for longitudinal line and cross section lines where points of elevation will be taken
interval_longitudinal=50; % meters
interval_width=10; % meters
% preference for the total width of the river
total_width=1000; % meters

[elev_grid,new_x,new_y,center_location] = longitudinal_DEM(DEMx,DEMy,DEMgrid,centerline_x,centerline_y,interval_longitudinal,interval_width,total_width);
