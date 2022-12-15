%% Init
clearvars;close all;clc;
data_path = 'E:\OneDrive\TLEs\final_mat_files\3-leo'; % path to data
addpath(data_path)
file_list = dir(data_path);

%%
for i=3:10
    
end

year_list = 1960:2014;
data_list = cell(length(year_list),1);

part = i-2;
data = load([file_list(i).folder,'\',file_list(i).name]).tle_data_leo;
for j=1:length(data)
    sat_name = data(j).name;
    sat_data = data(j).data;
    for k=1:length(sat_data)
        y = year(sat_data{k,'time'});
        index = find(y==year_list);
    end
end