%% Init
addpath(genpath(pwd));
close all
clearvars
clc

%% Read TLE
file_CHAMP = "./data/CHAMP.tle";
data_CHAMP = readtle(file_CHAMP);

file_GOCE = "./data/GOCE.tle";
data_GOCE = readtle(file_GOCE);

file_GRACE1 = "./data/GRACE1.tle";
data_GRACE1 = readtle(file_GRACE1);

file_GRACE2 = "./data/GRACE2.tle";
data_GRACE2 = readtle(file_GRACE2);

file_S3A = "./data/S3A.tle";
data_S3A = readtle(file_S3A);

file_S3B = "./data/S3B.tle";
data_S3B = readtle(file_S3B);

file_SWARM_A = "./data/SWARM_A.tle";
data_SWARM_A = readtle(file_SWARM_A);

file_SWARM_B = "./data/SWARM_B.tle";
data_SWARM_B = readtle(file_SWARM_B);

file_SWARM_C = "./data/SWARM_C.tle";
data_SWARM_C = readtle(file_SWARM_C);

%% Plot
plotelement(data_GRACE1,'GRACE-1');
plotelement(data_GRACE2,'GRACE-2');

plotelement(data_S3A,'Sentinel-3A');

plotelement(data_SWARM_C,'SWARM-C');

%% plot the differ for a and b
plotetaxi(data_GOCE)

plotetaxi(data_GRACE1)

plotetaxi(data_GRACE2)
