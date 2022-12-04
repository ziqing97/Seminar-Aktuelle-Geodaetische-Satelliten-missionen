function tle_data = read_all_tle(reload)
% this function allows us to read the information from tle file

% if reload == 1: regenerate all data from tle file in a struct
% if reload == 0: read this struct from a generated mat file
if reload
    tle_data = struct;
    tle_file_list = dir('./data/tle');
    j=1;
    for i=1:length(tle_file_list)
        if (tle_file_list(i).name ~= ".") && (tle_file_list(i).name ~= "..") && (tle_file_list(i).name ~= "catalog.txt")
            path = [tle_file_list(i).folder,'\',tle_file_list(i).name];
            tle_data(j).name = tle_file_list(i).name(1:end-3);
            tle_data(j).data = readtle(path);
            if ~mod(j,5)
                fprintf('%d files imported successfully!\n',j)
            end
            j = j+1;
        end
    end
    fprintf('all files imported successfully!\n')
    save('./data/tle_data.mat','tle_data')
else
    temp = load('./data/tle_data.mat','tle_data');
    tle_data = temp.tle_data;
end
end