function [] = Terrestrial(raw)

%Get the lat,long and follower data and convert back to double
lattitude = cell2mat(raw(:,11));
longitude = cell2mat(raw(:,12));
altitude = cell2mat(raw(:,16));

%Output filename
filename = 'terrestrial.kml';

%Write the data to the kml file
kmlwritepoint(filename,lattitude,longitude,altitude);

end

