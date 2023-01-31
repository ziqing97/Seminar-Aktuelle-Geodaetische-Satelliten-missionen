%
clc;close all;clearvars

%
R = 6378137;
h = 600e3;
a = R+h;
for e = 0:0.01:0.05
    for AdM = 0.005:0.01:0.075
        object_orbit_integral(e,AdM,a)
    end
end


