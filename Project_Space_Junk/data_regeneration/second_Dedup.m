%% Init
clearvars;close all;clc;
data_path = 'E:\OneDrive\TLEs\final_mat_files'; % path to data
addpath(data_path)
%%
file_list = dir(data_path);
count = 0;
for i=1:length(file_list)
    if file_list(i).isdir
        continue
    end
    count = count+1;
    tle_data = load([file_list(i).folder,'\',file_list(i).name]).tle_struct;
    for j=1:length(tle_data)
        [~,ia] = unique(tle_data(j).data.time);
        tle_data(j).data = tle_data(j).data(ia,:);
    end
    save([file_list(i).folder,'\dedup_',file_list(i).name],'tle_data');
end