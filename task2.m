function [] = task2( raw )

figure;

%Map code taken from the visualization help
ax = usamap('conus');
states = shaperead('usastatelo', 'UseGeoCoords', true,...
  'Selector',...
  {@(name) ~any(strcmp(name,{'Alaska','Hawaii'})), 'Name'});
geoshow(ax, states, 'Facecolor',[1 1 1])
framem on; gridm on; mlabel on; plabel on

%Set title
title("Tweets by location");

%Tweet locations (lattitude, longitude)
coord = [raw{:,11};raw{:,12}];
coord = coord';

plotm(coord,'r.');


end

