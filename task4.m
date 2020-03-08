function [] = task4(raw)

%Another bar graph, this time of total numbers of followers per state

citystate = raw(:,14);
s = split(citystate, ', ');

%Get a vector of the followers for each user
followers = cell2mat(raw(:,16));

%Split the states and sort alphabetically
states = s(:,2);
states = string(states);
states = [states' ; followers'];
states = states';
states = sortrows(states);

%index variable for the states vector
i = 1;

%index variable for the graph matrix
j = 1;

while(i <= length(states))
    
    %Get the current state
    curr = states(i,1);
    
    %If the value is not 2, the format is off so we just skip it
    if(strlength(curr) ~= 2)
        continue
    end
    
    %Find the sum of the current state
    sum = 0;
    while(i <= length(states) && strcmp(states(i,1),curr))
        sum = sum + str2double(states(i,2));
        i = i + 1;
    end
    
    x(j) = curr;
    y(j) = sum;
    j = j+1;
    
    
end

%Plot
c = categorical(x);
figure;
bar(c,y);
title("Followers by State");
xlabel("State");
ylabel("Total Number of Followers");

%Save as a jpg
saveas(gcf,'task4.jpg');

end