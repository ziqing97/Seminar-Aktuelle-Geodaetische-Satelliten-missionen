% %
% clc;close all;clearvars
% 
% %
% R = 6378137;
% h = 600e3;
% a = R+h;
% for e = 0:0.01:0.05
%     for AdM = 0.005:0.01:0.075
%         object_orbit_integral(e,AdM,a)
%     end
% end


R = 6378137;
h = 600e3;
a = R+h;
e = 0;
AdM = 5/500;
object_orbit_integral(e,AdM,a)

e = 0;
AdM = 25/500;
object_orbit_integral(e,AdM,a)