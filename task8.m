function [] = task8(raw)

%Variable for storing all frames of the movie
frames = zeros(900,1200,3,60);

%All of the state codes so the data can be organized
codes = ["AL";"AZ";"AR";"CA";"CO";"CT";"DE";"FL";"GA";"ID";...
    "IL";"IN";"IA";"KS";"KY";"LA";"ME";"MD";"MA";"MI";"MN";"MS";"MO";...
    "MT";"NE";"NV";"NH";"NJ";"NM";"NY";"NC";"ND";"OH";"OK";"OR";"PA";...
    "RI";"SC";"SD";"TN";"TX";"UT";"VT";"VA";"WA";"WV";"WI";"WY"];

%Make sure there were no errors in codes and make them alphabetical
codes = sort(codes);

%Create a binsize 1/60th the length of the data
len = length(raw);
binsize = floor(len/60);

%Create the states vector and the states and time matrix
citystate = raw(:,14);
s = split(citystate, ', ');
states = s(:,2);
vals = [raw(:,4) , states];

%Make a tweets vector
tweets = zeros(length(codes),1);

for i = 1:60
    
    %Get the subset of the data for this frame;
    subset = vals(:,2);
    subset = subset(((i-1)*binsize+1):i*binsize);
    
    %Sort this data into alphabetical order
    subset = sort(subset);
    
    %Now we need to count the tweets per state and standardize them
    j = 1;
    
    while(j <= length(subset))
        curr = subset(j);
        
        %Find the sum of the current state
        sum = 0;
        while(j <= length(subset) && strcmp(subset(j),curr))
            sum = sum + 1;
            j = j + 1;
        end
        
        %Add this sum to its place in the tweets array
        for k = 1:length(codes)
            if(strcmp(codes(k),curr))
                tweets(k) = tweets(k) + sum;
                break;
            end
        end
        
        
    end
    
    %Now we have a tweets vector for this frame, lets standardize it and
    %make the frame
    newtweets = tweets;
    newtweets = [newtweets(1);0;newtweets(2:10);0;newtweets(11:end);0];
    
    %Find min and max from 
    myMin = newtweets(1);
    myMax = newtweets(1);
    
    for k = 2:length(newtweets)
        if(newtweets(k) < myMin)
            myMin = newtweets(k);
        end
        
        if(newtweets(k) > myMax)
            myMax = newtweets(k);
        end
    end
    %need to have it in all 60 frames so iterate and load it in
    load('map.mat');
    newtweets = (newtweets-myMin)./(myMax-myMin);
    
    %Change intensity of usa_image
    for k = 1:900
        for j = 1:1200
            if(state_mask(k,j) > 0 && state_mask(k,j) < 52)
                usa_image(k,j,1) = usa_image(k,j,1)*newtweets(state_mask(k,j));
                usa_image(k,j,2) = usa_image(k,j,2)*newtweets(state_mask(k,j));
                usa_image(k,j,3) = usa_image(k,j,3)*newtweets(state_mask(k,j));
            else
                %Blue ocean
                usa_image(i,j,:) = [0,0,255];
            end
        end
    end
    
    frames(:,:,:,i) = usa_image;
    
end

movie = immovie(frames);

%The movie is reversed so we flip it back
for i=1:length(movie)
    flipped(i) = movie(length(movie)+1-i);
end

%Play movie
implay(flipped);
end
