function dydt =odefun_msis(t, y, AdM)
% Funktion fuer die nummerische Integration von GOCE
% Nadine Sprügel 3317570
% Ziqing Yu 3218051

GM = 3.9865005e14;
% h_GOCE = 450 * 1000; % m
% f1_GOCE = drag_force_msis(dc,h_GOCE,[y(4);y(5);y(6)],AdM);

lla = ecef2lla([y(1),y(2),y(3)]);
t0 = datenum(2023,1,1,0,0,0);
t
t = t0 + t/3600/24;
yyyy = year(t0);
doy = floor(t - datenum(yyyy,1,1,0,0,0));
utsecond = (t - datenum(yyyy,1,1,0,0,0) - doy)*24*3600;


[T,rho] = atmosnrlmsise00(lla(3),lla(2),lla(1),yyyy,doy,utsecond);
rho_atm = rho(6);
v_sate = [y(4);y(5);y(6)];
C_d = 1;
f_atm = -1/2 * C_d * rho_atm * AdM * v_sate * norm(v_sate); % m/s^2

dydt=[y(4); 
      y(5);
      y(6);
      -y(1)*GM/norm(y(1:3))^3 + f_atm(1); 
      -y(2)*GM/norm(y(1:3))^3 + f_atm(2); 
      -y(3)*GM/norm(y(1:3))^3 + f_atm(3)];
end