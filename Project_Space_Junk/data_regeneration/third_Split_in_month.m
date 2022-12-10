%% Init
clearvars;close all;clc;
data_path = 'E:\OneDrive\TLEs\final_mat_files\dedup'; % path to data
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
if count < 9
    continue
end
%-----------------------------------------------------

% read data
tle_data = load([file_list(i).folder,'\',file_list(i).name]).tle_data;
data_year = str2double(file_list(i).name(10:13));

% split
for data_month=1:12
all_data_month_mean = struct;
for j=1:length(tle_data)
    data_month_mean = calc_mean_value(tle_data(j).data,data_year,data_month);
    all_data_month_mean(j).name = tle_data(j).name;
    all_data_month_mean(j).data = data_month_mean;
end

% and save
save([file_list(i).folder,num2str(data_year),'_',num2str(data_month),'.mat'],"all_data_month_mean")
fprintf('month %d generated!\n',data_month)
end
end



