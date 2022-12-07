%% 
clearvars;close all;clc

%%
main_data_path = 'E:\OneDrive\TLEs';
addpath(genpath(main_data_path))
folder_list = dir(main_data_path);

%% this should be a loop
folder = [folder_list(3).folder,'\',folder_list(3).name];
fo_name = folder_list(3).name(1:end-4);

file_list = dir(folder);
tle_struct = struct;
k = 1;
for j=1:length(file_list)
if (file_list(j).name~=".") && (file_list(j).name~="..") && (file_list(j).name(end-2:end)~="txt")
    fi_name = file_list(j).name(1:end-4);
    tle_file = [file_list(j).folder,'\',file_list(j).name];
    tle_data = import_tle(tle_file);
    tle_struct(k).name = fi_name;
    tle_data = calc_other_orbit_element(tle_data);
    tle_struct(k).data = tle_data;
    if ~mod(k,100)
        fprintf("%d files are imported\n",k)
    end
    k = k+1;
end
end
fprintf("all files are imported\n")
