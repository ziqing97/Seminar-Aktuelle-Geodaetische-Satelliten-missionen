%% Init
close all;clearvars;clc

%% read tle data
% 1 for regenerate all data and 0 for read the generated mat file
tle_data = read_all_tle(0);
