function [] = task7(raw)

%State abbreviations
codes = ["AL";"AZ";"AR";"CA";"CO";"CT";"DE";"FL";"GA";"ID";...
    "IL";"IN";"IA";"KS";"KY";"LA";"ME";"MD";"MA";"MI";"MN";"MS";"MO";...
    "MT";"NE";"NV";"NH";"NJ";"NM";"NY";"NC";"ND";"OH";"OK";"OR";"PA";...
    "RI";"SC";"SD";"TN";"TX";"UT";"VT";"VA";"WA";"WV";"WI";"WY"];

%States
citystate = raw(:,14);
s = split(citystate, ', ');
states = s(:,2);
states = string(states);

%Get all of the num followers
followers = raw(:,16);

nicknames = raw(:,6);

%didnt need to use the transpose down here couldve done comma seperated in brackets no transpose 
followers = [states' ; followers' ; nicknames']';
followers = sortrows(followers);

%index variable for the states vector
i = 1;

codes(:,2) = strings(length(codes),1);

while(i <= length(states))
    
    %Get the current state
    curr = followers(i,1);
    
    %If the value is not 2, the format is off so we just skip it
    if(strlength(curr) ~= 2)
        continue
    end
    
    %Find the max 
    max = 0;
    maxI = 0;
    while(i <= length(states) && strcmp(followers(i,1),curr))
        if(str2double(followers(i,2)) > max)
            max = str2double(followers(i,2));
            maxI = i;
        end
        i = i + 1;
    end
    
    %Add the most popular user to the codes matrix
    for j = 1:length(codes)
        if(strcmp(curr,codes(j)))
            codes(j,2) = followers(maxI,3);
            break
        end
    end
    
end

users = num2cell(codes(:,2));
users{49} = "";

%Now we can use the provided code:

load('map.mat');
%Create figure for plotting
figure; 
title("Most popular Users by State");
%load a map of the CONUS
ax = usamap('conus');
%select only states within CONUS
states = shaperead('usastatelo', 'UseGeoCoords', true,...
  'Selector',...
  {@(name) ~any(strcmp(name,{'Alaska','Hawaii'})), 'Name'});
%Show the state borders on the map with a white face
geoshow(ax, states, 'Facecolor',[1 1 1])
%Keep the axis on for refrence along with labels
framem on; gridm on; mlabel on; plabel on
%Get the coordinates for every state
lat = [states.LabelLat];
lon = [states.LabelLon];
%select the states that require text
tf = ingeoquad(lat, lon, latlim, lonlim);


%This line just plots the text on the map axis.
textm(lat(tf), lon(tf), users, ...
   'HorizontalAlignment', 'center')

%Save image as a jpg
saveas(gcf,'task7.jpg');

end

