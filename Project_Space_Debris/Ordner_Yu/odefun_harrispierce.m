function dydt =odefun_harrispierce(t, y, AdM, starttime)
% Constant
GM = 3.9865005e14;

%
ri = y(1:3);
vi = y(4:6);

%
t_matlab = starttime + t/3600/24;
yyyy = year(t_matlab);
mm = month(t_matlab);
dd = day(t_matlab);
HH = hour(t_matlab);
MM = minute(t_matlab);
SS = second(t_matlab);
utc_time = [yyyy,mm,dd,HH,MM,SS];

%
% re = eci2ecef(utc_time,ri);
re = ri;
% lla = ecef2lla([re(1),re(2),re(3)]);
% h = lla(3);
h = norm(ri)-6378137;
f1_hp = drag_force_hp(h,vi,AdM);
dydt=[vi(1); 
      vi(2);
      vi(3);
      -ri(1) * GM / norm(ri)^3 + f1_hp(1); 
      -ri(2) * GM / norm(ri)^3 + f1_hp(2); 
      -ri(3) * GM / norm(ri)^3 + f1_hp(3)];
end