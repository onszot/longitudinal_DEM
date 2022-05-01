function [elev_grid,new_x,new_y,center_location] = longitudinal_DEM(DEMx,DEMy,DEMgrid,centerline_x,centerline_y,interval_longitudinal,interval_width,total_width)
    %***************************************************************************************************
    % Creates a digital elevation model (DEM) following the axis of a centerline.  
    % Developed with the primary purpose to capture numerous cross-sectional profiles 
    % along the longitudinal axis of rivers/estuaries.  
    %***************************************************************************************************
    % Inputs:
    %   DEMx: x data for DEM, (1-dimensional array, not a grid), UTM
    %   DEMy: y data for DEM (1-dimensional array, not a grid), UTM
    %   DEMgrid: DEM grid, elevation in meters.
    %   centerline_x: x coordinates of centerline transect (string), UTM
    %   centerline_y: y coordinates of centerline transect(string), UTM
    %   interval_longidudinal : interval along the centerline of cross-sections, 
    %   capturing the longitudinal spacing, in meters.  
    %   interval_width: interval along the cross-section where elevations will be identified 
    %   (i.e., lateral spacing, lines which are perpendicular to the centerline), in meters.
    %   total_width: : total length of cross-section (perpendicular to the centerline), in meters. 
    %
    % Outputs:
    %   contour plot of elevation
    %   elev_grid: grid of elevation data, in meters, with axes of new_y-by-new_x.
    %   new_x: new x array for elev_grid, in meters
    %   new_y: new y array for elev_grid, in meters
    %   center_location: center location of each cross-section, corresponding to input x-y coordinates 
    %***************************************************************************************************
    %
    %***************************************************************************************************
    % [elev_grid,new_x,new_y,center_location] = longitudinal_DEM(DEMx,DEMy,DEMgrid,centerline_x,centerline_y,interval_longitudinal,interval_width,total_width)
    % **************************************************************************************************
    % Written by Olivia Szot and Steven L. Dykstraa, UofSC, 2022
    % **************************************************************************************************

if nargin < 8
    error('MATLAB:notEnoughInputs', 'Not enough input arguments.');
end
if length(interval_width) >1
    error('Error. Interval width must be single variable.');
end
if length(interval_longitudinal)>1
    error('Error. longitudinal interval must be single variable.');
end
if length(total_width)>1
    error('Error. Total width must be single variable.');
end
if length(DEMx) ~= size(DEMgrid,2) || length(DEMy) ~= size(DEMgrid,1)
    error('Error. DEM dimensions must agree.');
end

RDist=sqrt(diff(centerline_x).^2+diff(centerline_y).^2); % find distance between each coordinate point
RDist=cumsum(RDist); % find total length of river
RDist=[0;RDist]; 

% longitudinal locations, cross-sectional locations 
xq=(RDist(1,1):interval_longitudinal:RDist(end,1))'; 
crossLoc(:,1)=xq; % set reference points along the transect line for each longitudinal interval
crossLoc(:,2)=interp1(RDist,centerline_x,xq); %interpolate to find points along line
crossLoc(:,3)=interp1(RDist,centerline_y,xq);
for i=1:length(crossLoc) % loop to make cross-sectional lines along each point on the longitudinal interval
    p1x(i)=crossLoc(i,2);
    p1y(i)=crossLoc(i,3);
    next_points=find(xq(i)<RDist); % finds the local trajectory of the river. Alternatively, could be done to find the trajectory between two intervals.  
    p2x(i)=centerline_x(next_points(1));
    p2y(i)=centerline_y(next_points(1));
    % find line perpendicular to centerline
    AA=[p1x(i) p1y(i)];
    B=[p2x(i) p2y(i)]; 
    AB=B-AA;
    AB=AB/norm(AB);
    ABperp=AB*[0 -1;1 0];
    % find endpoints of each cross-sectional line
    ABmid=[crossLoc(i,2) crossLoc(i,3)];
    c=ABmid+(total_width/2)*ABperp;
    d=ABmid-(total_width/2)*ABperp;
    C(i,1)=c(1);
    C(i,2)=c(2);
    D(i,1)=d(1);
    D(i,2)=d(2);
    % plot of river centerline and all cross-sectional lines; uncomment to
    % show, causes code to run longer depending on set interval_longitudinal
    % plot([AA(1);B(1)],[AA(2);B(2)],'-k',[C(i,1);D(i,1)],[C(i,2);D(i,2)],'-r');
    % hold on
    % axis equal;
end

for i=1:length(C) % get equally spaced points on the cross section lines
    XX{i}=linspace(D(i,1),C(i,1),total_width/interval_width+1);
    YY{i}=linspace(D(i,2),C(i,2),total_width/interval_width+1);
end

for j=1:length(C) % convert cells into matrix array
    xx(:,j)=[XX{j}]; 
    yy(:,j)=[YY{j}];
end
% find elevation 
elev_grid=interp2(DEMx,DEMy,DEMgrid,xx,yy,"nearest")'; 
Cwidth=total_width/2;
new_x=linspace(-Cwidth,Cwidth,total_width/interval_width+1);
new_y=0:interval_longitudinal:RDist(end);
center_location=crossLoc(1:end-1,2:3);
% plotting results:
% can comment out all below if you prefer to create your own plot using new_x, new_y, and elev_grid
figure; 
axes('Position',[.1 .1 .3 .8])
pcolor(new_x,new_y',elev_grid);
hold on;
contour(new_x,new_y',elev_grid,[0 0],'k');
shading interp;
colormap turbo;
c=colorbar('eastoutside');
c.Label.String = 'Elevation [m]';
xlabel('lateral distance [m]');
ylabel('distance inland [m]');
set(gca,'DataAspectRatio',[1 11 1])
hold off;
end
