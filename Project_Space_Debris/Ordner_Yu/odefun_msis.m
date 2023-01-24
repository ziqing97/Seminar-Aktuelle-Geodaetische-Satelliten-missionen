function dydt =odefun_msis(t,y,AdM,starttime)
GM = 3.9865005e14;

ri = y(1:3);
vi = y(4:6);

t_matlab = starttime + t/3600/24;
yyyy = year(t_matlab);
mm = month(t_matlab);
dd = day(t_matlab);
HH = hour(t_matlab);
MM = minute(t_matlab);
SS = second(t_matlab);
doy = floor(datenum(t_matlab) - datenum(yyyy,1,1,0,0,0));
utsecond = (t - datenum(yyyy,1,1,0,0,0) - doy)*24*3600;
utc_time = [yyyy,mm,dd,HH,MM,SS];


re = eci2ecef(utc_time,ri);
lla = ecef2lla([re(1),re(2),re(3)]);

[~, rho] = atmosnrlmsise00(lla(3),lla(2),lla(1),yyyy,doy,utsecond);
rho_atm = rho(6);

C_d = 2.5;
f_atm = -1/2 * C_d * rho_atm * AdM * vi * norm(vi); % m/s^2

dydt=[vi(1); 
      vi(2);
      vi(3);
      -ri(1) * GM / norm(ri)^3 + f_atm(1); 
      -ri(2) * GM / norm(ri)^3 + f_atm(2); 
      -ri(3) * GM / norm(ri)^3 + f_atm(3)];
end