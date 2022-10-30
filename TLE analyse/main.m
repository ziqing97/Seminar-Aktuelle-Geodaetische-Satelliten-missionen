%% Init
addpath(genpath(pwd));
close all
clearvars
clc

%% Read TLE
file_CHAMP = "./data/CHAMP.tle";
data_CHAMP = readtle(file_CHAMP);

file_SWARM_A = "./data/SWARM_A.tle";
data_SWARM_A = readtle(file_SWARM_A);

%% Plot
plotelement(data_SWARM_A)

