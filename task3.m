function [numtweets, stateAbrev] = task3(raw)

citystate = raw(:,14);
s = split(citystate, ', ');

states = s(:,2);
states = sort(states);
states = string(states);

%index variable for the states vector
i = 1;

%index variable for the graph matrix
j = 1;

while(i <= length(states))
    
    %Get the current state
    curr = states(i);
    
    %If the value is not 2, the format is off so we just skip it
    if(strlength(curr) ~= 2)
        continue
    end
    
    %Find the sum of the current state
    sum = 0;
    while(i <= length(states) && strcmp(states(i),curr))
        sum = sum + 1;
        i = i + 1;
    end
    
    x(j) = curr;
    y(j) = sum;
    j = j+1;
    
    
end

%Plot4
c = categorical(x);
figure;
bar(c,y);
title("Tweets by State");
xlabel("State");
ylabel("Number of Tweets");

%Save the image as a jpg
saveas(gcf,'task3.jpg');

numtweets = y;
stateAbrev = x;

end