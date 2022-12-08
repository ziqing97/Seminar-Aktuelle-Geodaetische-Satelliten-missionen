%% Init
clearvars;close all;clc;
data_path = 'E:\final_mat_files\dedu'; % path to data
addpath(data_path)
file_list = dir(data_path);
count = 0;

%% Begin
for i=1:length(file_list)
%% necessary controll for iteration
if file_list(i).isdir
    continue
end
count = count+1;
% --------------- controll trigger--------------------
if count ~= 10
    continue
end
%-----------------------------------------------------

%% read data
tle_data = load([file_list(i).folder,'\',file_list(i).name]).tle_data;
end