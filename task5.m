function [] = task5(tweets, states)

load('map.mat');

%State abbreviations
codes = ["AL";"AZ";"AR";"CA";"CO";"CT";"DE";"FL";"GA";"ID";...
    "IL";"IN";"IA";"KS";"KY";"LA";"ME";"MD";"MA";"MI";"MN";"MS";"MO";...
    "MT";"NE";"NV";"NH";"NJ";"NM";"NY";"NC";"ND";"OH";"OK";"OR";"PA";...
    "RI";"SC";"SD";"TN";"TX";"UT";"VT";"VA";"WA";"WV";"WI";"WY"];

%Sort just in case
codes = sort(codes);

%We need to standardize the tweets and states vectors
i = 1;

newtweets = zeros(1,length(codes));

for j = 1:length(codes)
    %Make the tweets match up with the codes vector
    if(i <= length(tweets) && strcmp(codes(j),states(i)))
        newtweets(j) = tweets(i);
        i = i + 1;
    end
end

%Lets add back Hawaii and Alaska so the indexing will work
%AL is the second element, HI is the 11th, state_names also has dc as last
%element so fix that as well

newtweets = [newtweets(1),0,newtweets(2:10),0,newtweets(11:end),0];


%Find the min and max
myMin = newtweets(1);
myMax = newtweets(1);

for i = 2:length(newtweets)
    if(newtweets(i) < myMin)
        myMin = newtweets(i);
    end
    
    if(newtweets(i) > myMax)
        myMax = newtweets(i);
    end
end

%Normalize the numbers to be between 0 and 1
newtweets = (newtweets-myMin)./(myMax-myMin);

%Change the intensity of the usa_image based on newtweets
for i = 1:900
    for j = 1:1200
        if(state_mask(i,j) > 0 && state_mask(i,j) < 52)
            usa_image(i,j,1) = usa_image(i,j,1)*newtweets(state_mask(i,j));
            usa_image(i,j,2) = usa_image(i,j,2)*newtweets(state_mask(i,j));
            usa_image(i,j,3) = usa_image(i,j,3)*newtweets(state_mask(i,j));
        else
            %Blue ocean
            usa_image(i,j,:) = [0,0,255];
        end
    end
end

%Plot
figure
imagesc(usa_image);
title("Number of Tweets per State as Color Intensity");

%Save image as a jpg
saveas(gcf,'task5.jpg');


end

