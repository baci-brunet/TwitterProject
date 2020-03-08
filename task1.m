function [ raw ] = task1(filename)

%Import the excel data
[~,~,raw] = xlsread(filename);

%Length of the data
len = length(raw);

%Keep track of indicies to delete
indices = [];
j = 1;

%Iterate through the cell array cleaning data
for i = 1:len
    
    %The parameters we use to clean are on columns 13,14,19
    country = raw{i,13};
    location = raw{i,14};
    lang = raw{i,19};
    
    %Check if any of the values are NaN
    if(length(country) == 1 || length(location) == 1 || length(lang) == 1)
        indices(j) = i;
        j = j+1;
        continue
    end
    
    %Use strsplit to separate the two values from string
    citystate = strsplit(location, ', ');
    
    %There are a few errors in the file, so if the location isn't formatted
    %correct just move on
    if(length(citystate) == 1)
        indices(j) = i;
        j = j+1;
        continue
    end
        
    %Make sure the tweet meets the criteria before adding it
    if(~strcmp(country,'US') || ~strcmp(lang,'en') || strcmp(citystate(2),'AK') || strcmp(citystate(2), 'HI') || strcmp(citystate(2), 'DC') || strlength(citystate(2)) ~= 2)
        indices(j) = i;
        j = j+1;
    end
    
end

%Now we should delete rows indicated by indices
raw(indices,:) = [];

%Print out how many tweets remain
fprintf("There are %i tweets remaining, all from the Continental US, all using the English language.\n",length(raw));

end

