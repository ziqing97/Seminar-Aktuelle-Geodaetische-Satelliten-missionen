function[result_noforce,result_harris_priester,result_msis] = ...
         orbit_integral(a,e,I,Omega,w,M,AdM,t0,tspan)

%% Some settings
options = odeset('RelTol',1e-15,'AbsTol',1e-15);
warning('off')
% Constant
GM = 3.9865005e14;   % m^3/s^2

% transformation from kepler elements to ECI
[ri,vi] = kep2eci(I,Omega,w,M,e,a,GM);  % meter for r and m/s for v
koori = [ri;vi];

noforce = 1;
hp = 1;
msis = 0;

%% orbit intergral
if noforce == 1
    % Kepler Elemente no atmospheric force
    [T1, Y1] = ode113(@(t,y)odefun_noforce(t,y), tspan, koori, options);
    l1 = length(Y1);
    I_Gk1 = zeros(l1,1);
    e_Gk1 = zeros(l1,1);
    a_Gk1 = zeros(l1,1);
    for i=1:length(Y1)
        [I_Gk1(i),~,~,~,e_Gk1(i),a_Gk1(i)] = cart2kep(Y1(i,1:3)',Y1(i,4:6)',GM);
    end
    result_noforce = [T1,a_Gk1,e_Gk1,I_Gk1];
    disp('1 done')
else
    result_noforce = [];
end

if hp == 1
    % Kepler Elemente harris-priester model
    [T2, Y2] = ode113(@(t,y)odefun_harrispierce(t,y,AdM,t0), tspan, koori, options);
    l2 = length(Y2);
    I_Gk2 = zeros(l2,1);
    e_Gk2 = zeros(l2,1);
    a_Gk2 = zeros(l2,1);
    for i=1:length(Y2)
        [I_Gk2(i),~,~,~,e_Gk2(i),a_Gk2(i)] = cart2kep(Y2(i,1:3)',Y2(i,4:6)',GM);
    end
    result_harris_priester = [T2,a_Gk2,e_Gk2,I_Gk2];
    disp('2 done')
else
    result_harris_priester = [];
end

if msis==1
    % Kepler Elemente msis model
    [T3, Y3] = ode113(@(t,y)odefun_msis(t,y,AdM,t0), tspan, koori, options);
    l3 = length(Y3);
    I_Gk3 = zeros(l3,1);
    e_Gk3 = zeros(l3,1);
    a_Gk3 = zeros(l3,1);
    for i=1:length(Y3)
        [I_Gk3(i),~,~,~,e_Gk3(i),a_Gk3(i)] = cart2kep(Y3(i,1:3)',Y3(i,4:6)',GM);
    end
    result_msis = [T3,a_Gk3,e_Gk3,I_Gk3];
    disp('3 done')
else
    result_msis = [];
end
end