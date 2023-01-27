%% init
clearvars;close all;clc

%% get the file location
main_data_path = 'F:\TLE\RESULT\CSV';
addpath(genpath(main_data_path))
folder_list = dir(main_data_path);

%% read and save
for i=1:length(folder_list)
    if i<3
        continue
    end
    folder = [folder_list(i).folder,'\',folder_list(i).name];
    fo_name = folder_list(i).name(end-3:end);
    file_list = dir(folder);
    tle_struct = struct;
    k = 1;
    for j=1:length(file_list)
    if (file_list(j).isdir==0) && (file_list(j).name(end-2:end)~="txt")
        tle_data = import_tle([file_list(j).folder,'\',file_list(j).name]);
        tle_struct(k).name = file_list(j).name(1:end-4);
        tle_struct(k).data = calc_other_orbit_element(tle_data);
        if ~mod(k,100)
            fprintf("%d files are imported\n",k)
        end
        k = k+1;
    end
    end
    fprintf("all files are imported\n")
    save(['F:\TLE\matlab_raw\',fo_name,'.mat'],'tle_struct')
end
