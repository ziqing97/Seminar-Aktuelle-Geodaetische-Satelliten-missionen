%% init
clearvars;close all;clc

%% get the file location
main_data_path = 'E:\OneDrive\TLEs';
addpath(genpath(main_data_path))
folder_list = dir(main_data_path);

%% read and save
for i=1:length(folder_list)
    if i<4 || i>11
        continue
    end
    folder = [folder_list(i).folder,'\',folder_list(i).name];
    fo_name = folder_list(i).name(1:end-4);
    
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
    save(['E:\OneDrive\TLEs\final_mat_files\',fo_name,'.mat'],'tle_struct')
end
