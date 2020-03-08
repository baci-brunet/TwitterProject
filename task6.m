function [] = task6(raw)

%Citystate, then split to just state
citystate = raw(:,14);
s = split(citystate, ', ');
states = s(:,2);
states = string(states);

%Get all of the tweets
tweets = string(raw(:,8));

%Sort all tweets in state alphabetical order
vals = [states , tweets];
vals = sortrows(vals);

i = 1;

%Store all the most common hashtags per state
pop_tags = "";
a = 1;

while i<=length(vals)
    
    %Get the current state
    curr = vals(i,1);
    
    %If the value is not 2, the format is off so we just skip it
    if(strlength(curr) ~= 2)
        continue
    end
    
    hashtags = "";
    j = 1;
    
    %Find all hashtags from the current state and add to hashtags
    while(i <= length(states) && strcmp(vals(i,1),curr))
        splits = split(vals(i,2));
        for k = 1:length(splits)
            if(strncmpi(splits(k),"#",1))
                hashtags(j) = splits(k);
                j = j+1;
            end
        end
        i = i + 1;
    end
    
    pop_tags(a,1) = curr;
    pop_tags(a,2) = mode(hashtags);
    
    a = a + 1;

end

%State abbreviations vector
codes = ["AL";"AZ";"AR";"CA";"CO";"CT";"DE";"FL";"GA";"ID";...
    "IL";"IN";"IA";"KS";"KY";"LA";"ME";"MD";"MA";"MI";"MN";"MS";"MO";...
    "MT";"NE";"NV";"NH";"NJ";"NM";"NY";"NC";"ND";"OH";"OK";"OR";"PA";...
    "RI";"SC";"SD";"TN";"TX";"UT";"VT";"VA";"WA";"WV";"WI";"WY"];

%If there are some states not included we need to standardize the pop_tags
%matrix

new_pop = strings(length(codes),2);
new_pop(:,1) = codes;

for i = 1:length(codes)
    for j = 1:length(pop_tags)
        if(strcmp(pop_tags(j,1),codes(i)))
            new_pop(i,2) = pop_tags(j,2);
            break;
        end
    end
end

%Now we have a matrix with states and their corresponding most popular
%hashtags, so convert to a cell array for use in the map

%dc is the 49th cell in the array, we need to delete it.
%in the cell array there are the 51 states minus hawaii and alaska
tag_cell = num2cell(new_pop(:,2));
tag_cell{49} = "";

%Now we can use the provided code:

load('map.mat');
%Create figure for plotting
figure; 
title("Most popular Hashtags by State");
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
textm(lat(tf), lon(tf), tag_cell, ...
   'HorizontalAlignment', 'center')

%Save image as a jpg
saveas(gcf,'task6.jpg');

end

