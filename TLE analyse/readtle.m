function data = readtle(file)
% this function reads the .tle file and generates a
% matlab struct

EOP = readmatrix(file,"FileType","text");
num = size(EOP,1)/2;

time = zeros(num,1);
inclination = zeros(num,1);
e = zeros(num,1);
AoP = zeros(num,1);
mean_anomaly = zeros(num,1);
mean_motion = zeros(num,1);
period = zeros(num,1);
a = zeros(num,1);
b = zeros(num,1);

fd = fopen(file,'r');
if fd < 0
    error("Can't open this file!")
end

A1 = fgetl(fd);
A2 = fgetl(fd);
count = 1;
while ischar(A2)
    assert(chksum(A1), 'Checksum failure on line 1')
    assert(chksum(A2), 'Checksum failure on line 2')
    %% direct read from data
    % satnum
    satnum = str2double(A1(3:7));
    % time
    year = str2double(A1(19:20))+2000;
    rest = str2double(A1(21:32));
    time(count) = datenum(year,1,1,0,0,0)+rest;
    % Inclination
    inclination(count) = str2double(A2(9:16));
    % Eccentricity
    e(count) = str2double(A2(27:33))*10^(-7);
    % Argument of Perigee
    AoP(count) = str2double(A2(35:42));
    % Mean Anomaly
    mean_anomaly(count) = str2double(A2(44:51));
    % Mean Motion
    mean_motion(count) = str2double(A2(53:63));
    
    %% other things to calculate
    % period
    period(count) = 86164.091/mean_motion(count); % sidereal year
    % semi-major axis
    a(count) = ((period(count)/(2*pi))^2*398.6e12)^(1/3);
    % semi-minor axis
    b(count) = a(count)*sqrt(1-e(count)^2);
    %% read next epoch
    A1 = fgetl(fd);
    A2 = fgetl(fd);
    count = count+1;
end
data = table(time,inclination,e,AoP,mean_anomaly,mean_motion,period,a,b,'VariableNames',...
    {'time','inclination','e','AoP','mean_anomaly','mean_motion','period','a','b'});
end