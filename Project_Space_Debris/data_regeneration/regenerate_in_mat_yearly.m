%% init
clearvars;close all;clc

%% get the file location
main_data_path = 'F:\TLE\RESULT\CSV';
addpath(genpath(main_data_path))
folder_list = dir(main_data_path);

%% read and save raw matlab
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

%% dedup
clearvars;close all;clc;
data_path = 'F:\TLE\matlab_raw\'; % path to data
addpath(data_path)
%
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
    fprintf("%d files are imported\n",count)
    save(['F:\TLE\matlab_dedup\',file_list(i).name(1:4)],'tle_data');
end


clearvars;close all;clc;
data_path = 'F:\TLE\matlab_dedup'; % path to data
addpath(data_path)
file_list = dir(data_path);
count = 0;

%% Divide into leo and non-leo
for i=1:length(file_list)
    if file_list(i).isdir
        continue
    end
    count = count+1;
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
    save(['F:\TLE\RESULT\MAT_Year\LEO\leo',file_list(i).name(1:4)],'tle_data_leo');
    save(['F:\TLE\RESULT\MAT_Year\NONLEO\nonleo',file_list(i).name(1:4)],'tle_data_non_leo');
end

