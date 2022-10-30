function data = readtle(file)
% this function reads the .tle file and generates a
% matlab struct
fd = fopen(file,'r');
if fd < 0
    error("Can't open this file!")
end

time = [];
inclination = [];
e = [];
AoP = [];
mean_anomaly = [];
mean_motion = [];
period = [];
a = [];
b = [];

A1 = fgetl(fd);
A2 = fgetl(fd);
while ischar(A2)
    assert(chksum(A1), 'Checksum failure on line 1')
    assert(chksum(A2), 'Checksum failure on line 2')
    %% direct read from data
    % satnum
    satnum = str2double(A1(3:7));
    % time
    year = str2double(A1(19:20))+2000;
    rest = str2double(A1(21:32));
    time(end+1) = datenum(year,1,1,0,0,0)+rest;
    % Inclination
    inclination(end+1) = str2double(A2(9:16));
    % Eccentricity
    e(end+1) = str2double(A2(27:33))*10^(-7);
    % Argument of Perigee
    AoP(end+1) = str2double(A2(35:42));
    % Mean Anomaly
    mean_anomaly(end+1) = str2double(A2(44:51));
    % Mean Motion
    mean_motion(end+1) = str2double(A2(53:63));
    
    %% other things to calculate
    % period
    period(end+1) = 86164.091/mean_motion(end); % sidereal year
    % semi-major axis
    a(end+1) = ((period(end)/(2*pi))^2*398.6e12)^(1/3);
    % semi-minor axis
    b(end+1) = a(end)*sqrt(1-e(end)^2);
    %% read next epoch
    A1 = fgetl(fd);
    A2 = fgetl(fd);
end
data = struct;
data.time = time;
data.inclination = inclination;
data.e = e;
data.AoP = AoP;
data.mean_anomaly = mean_anomaly;
data.mean_motion = mean_motion;
data.period = period;
data.a = a;
data.b = b;
end