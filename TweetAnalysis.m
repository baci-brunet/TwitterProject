clear; clc; close all;

%File
filename = 'parsed_tweets_small.xlsx';

%%%%%%%%%%%%%%
%TASK 1:
%%%%%%%%%%%%%%

%Input the filename and task1 will output the cleaned data as a cell array
raw = task1(filename);

%%%%%%%%%%%%%%
%TASK 2
%%%%%%%%%%%%%%

%Input the cell array and task2 will plot the tweet data on the map
task2(raw);

%%%%%%%%%%%%%%
%TASK 3
%%%%%%%%%%%%%%

%Input the cell array and the output will be the number of tweets and state
%abbreviations at the same indicies
[tweets, states] = task3(raw);

%%%%%%%%%%%%%%
%TASK 4
%%%%%%%%%%%%%%

%Total number of followers per state bar graph
task4(raw);

%%%%%%%%%%%%%%
%TASK 5
%%%%%%%%%%%%%%

%Colormap based on number of tweets per state
task5(tweets,states);

%%%%%%%%%%%%%%
%TASK 6
%%%%%%%%%%%%%%

%Most popular hashtags per state
task6(raw);

%%%%%%%%%%%%%%
%TASK 7
%%%%%%%%%%%%%%

%Most popular user per state
task7(raw);

%%%%%%%%%%%%%%
%TASK 8
%%%%%%%%%%%%%%

%Movie animation of task 5 based chronologically
task8(raw);

%%%%%%%%%%%%%%
%EXTRA CREDIT 1
%%%%%%%%%%%%%%

Terrestrial(raw);

