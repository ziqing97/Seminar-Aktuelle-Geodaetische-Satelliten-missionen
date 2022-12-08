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
%tle_data = load([file_list(i).folder,'\',file_list(i).name]).tle_data;
end



%%

tle_data = load('E:\final_mat_files\dedu\dedup_tle2005.mat').tle_data;
data_year = 2006;
for data_month=1:12
all_data_month_mean = struct;
for j=1:length(tle_data)
    data_month_mean = calc_mean_value(tle_data(j).data,data_year,data_month);
    all_data_month_mean(j).name = tle_data(j).name;
    all_data_month_mean(j).data = data_month_mean;
end

save([num2str(data_year),'_',num2str(data_month),'.mat'],"all_data_month_mean")
fprintf('month %d generated!\n',data_month)
end