%% Init
clearvars;close all;clc;
data_path = 'E:\OneDrive\TLEs\final_mat_files\2-dedup'; % path to data
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

% if count<5
%     continue
% end

tle_data = load([file_list(i).folder,'\',file_list(i).name]).tle_data;

tle_data_leo = struct;
count_leo = 1;
tle_data_non_leo = struct;
count_non_leo = 1;

for j=1:length(tle_data)
    data = tle_data(j).data;
    name = tle_data(j).name;
    data.apo = data.a .* (1+data.eccentricity);
    data.per = data.a .* (1-data.eccentricity);
    if (data.eccentricity(1) < 0.25) && (data.period(1) < 128*60)
        tle_data_leo(count_leo).name = name;
        tle_data_leo(count_leo).data = data;
        count_leo = count_leo+1;
    else
        tle_data_non_leo(count_non_leo).name = name;
        tle_data_non_leo(count_non_leo).data = data;
        count_non_leo = count_non_leo + 1;
    end
end
save(['E:\OneDrive\TLEs\final_mat_files\3-leo\leo_',file_list(i).name(10:end)],'tle_data_leo');
save(['E:\OneDrive\TLEs\final_mat_files\3-non_leo\non_leo_',file_list(i).name(10:end)],'tle_data_non_leo');
end



