%% Init
addpath(genpath(pwd));
close all
clearvars
clc

%% Read TLE
% file_CHAMP = "./data/CHAMP.tle";
% data_CHAMP = readtle(file_CHAMP);
% 
% file_GOCE = "./data/GOCE.tle";
% data_GOCE = readtle(file_GOCE);
% 
% file_GRACE1 = "./data/GRACE1.tle";
% data_GRACE1 = readtle(file_GRACE1);
% 
% file_GRACE2 = "./data/GRACE2.tle";
% data_GRACE2 = readtle(file_GRACE2);

file_S3A = "./data/S3A.tle";
data_S3A = readtle(file_S3A);

file_S3B = "./data/S3B.tle";
data_S3B = readtle(file_S3B);
% 
% file_SWARM_A = "./data/SWARM_A.tle";
% data_SWARM_A = readtle(file_SWARM_A);
% 
% file_SWARM_B = "./data/SWARM_B.tle";
% data_SWARM_B = readtle(file_SWARM_B);
% 
% file_SWARM_C = "./data/SWARM_C.tle";
% data_SWARM_C = readtle(file_SWARM_C);

%% Plot timeseries
% plotelement(data_GOCE,'GOCE',[])
% 
% plotelement(data_CHAMP,'CHAMP',[731559,732759])

plotelement(data_S3A,'S3A',[datenum(2016,7,12),738530])
 
plotelement(data_S3B,'S3B',[datenum(2018,10,17),datenum(2018,11,22)])
 
% plotelement(data_GRACE1,'GRACE 1',[])
% 
% plotelement(data_GRACE2,'GRACE 2',[])
% 
% plotelement(data_SWARM_A,'SWARM A',[735682])
% 
% plotelement(data_SWARM_B,'SWARM B',[735674,738597])
% 
% plotelement(data_SWARM_C,'SWARM C',[735711])

%% Plot eta and xi
% plotetaxi(data_GOCE,'GOCE',[])
% 
% plotetaxi(data_CHAMP,'CHAMP',[731559,732759]) 

plotetaxi(data_S3A,'S3A',[datenum(2016,7,12),738530])

plotetaxi(data_S3B,'S3B',[datenum(2018,10,17),datenum(2018,11,22)])
% 
% plotetaxi(data_GRACE1,'GRACE 1',[])
% 
% plotetaxi(data_GRACE2,'GRACE 2',[])
% 
% plotetaxi(data_SWARM_A,'SWARM A',[735682])
% 
% plotetaxi(data_SWARM_B,'SWARM B',[735674,738597])
% 
% plotetaxi(data_SWARM_C,'SWARM C',[735711])

%% Compare S3A and S3B
t_s3a = datenum(2016,7,12);
t_s3b = datenum(2018,11,22);
compare_timeseries_sentinel({data_S3A,data_S3B},{'S3A','S3B'},[t_s3a,t_s3b])

%% compute drift at equator

r_p_S3A = 27; % repeat period of 27 days in seconds
r_p_S3B = 27; % repeat period of 27 days in seconds
eq_drift(data_S3A,r_p_S3A,datenum(2016,7,12),'S3A')
eq_drift(data_S3B,r_p_S3B,datenum(2018,11,22),'S3B')

%% Compare Swarm A,B,C
% compare_timeseries_swarm({data_SWARM_A,data_SWARM_B,data_SWARM_C},...
%     {'SWARM-A','SWARM-B','SWARM-C'},[])