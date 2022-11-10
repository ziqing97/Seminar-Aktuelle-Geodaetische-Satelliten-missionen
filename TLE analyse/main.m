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
plotetaxi(data_GOCE, 'GOCE')

plotetaxi(data_CHAMP, 'CHAMP')

plotetaxi(data_S3A,'S3A')

plotetaxi(data_S3B, 'S3B')

plotetaxi(data_GRACE1, 'GRACE 1')

plotetaxi(data_GRACE2, 'GRACE 2')

plotetaxi(data_SWARM_A, 'SWARM A')

plotetaxi(data_SWARM_B, 'SWARM B')

plotetaxi(data_SWARM_C, 'SWARM C')

%% plot
plotetaxi(data_GOCE, 'GOCE',2009)

plotetaxi(data_CHAMP, 'CHAMP',2003)

plotetaxi(data_S3A,'S3A', 2017)

plotetaxi(data_S3B, 'S3B',2019)

plotetaxi(data_GRACE1, 'GRACE 1',2010)

plotetaxi(data_GRACE2, 'GRACE 2',2010)

plotetaxi(data_SWARM_A, 'SWARM A',2015)

plotetaxi(data_SWARM_B, 'SWARM B',2015)

plotetaxi(data_SWARM_C, 'SWARM C',2015)
