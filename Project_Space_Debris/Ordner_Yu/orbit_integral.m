function[result] = orbit_integral(a,e,I,Omega,w,M,AdM,t0,tspan,trigger)

%% Some settings
options = odeset('RelTol',1e-15,'AbsTol',1e-15);
warning('off')

% transformation from kepler elements to ECI
[ri,vi] = kep2eci(I,Omega,w,M,e,a);  % meter for r and m/s for v
koori = [ri;vi];

%% orbit intergral
if trigger == "noforce"
    % Kepler Elemente no atmospheric force
    [T1, Y1] = ode113(@(t,y)odefun_noforce(t,y), tspan, koori, options);
    l1 = length(Y1);
    I_Gk1 = zeros(l1,1);
    e_Gk1 = zeros(l1,1);
    a_Gk1 = zeros(l1,1);
    Omega_Gk1 = zeros(l1,1);
    w_Gk1 = zeros(l1,1);
    M_Gk1 = zeros(l1,1);
    for i=1:length(Y1)
        [I_Gk1(i),Omega_Gk1(i),...
         w_Gk1(i),M_Gk1(i),e_Gk1(i),a_Gk1(i)] = eci2kep(Y1(i,1:3)',Y1(i,4:6)');
    end
    result = [T1,a_Gk1,e_Gk1,I_Gk1,Omega_Gk1,w_Gk1,M_Gk1];
elseif trigger == "hp"
    % Kepler Elemente harris-priester model
    [T2, Y2] = ode113(@(t,y)odefun_harrispierce(t,y,AdM,t0), tspan, koori, options);
    l2 = length(Y2);
    I_Gk2 = zeros(l2,1);
    e_Gk2 = zeros(l2,1);
    a_Gk2 = zeros(l2,1);
    Omega_Gk2 = zeros(l2,1);
    w_Gk2 = zeros(l2,1);
    M_Gk2 = zeros(l2,1);
    for i=1:length(Y2)
        [I_Gk2(i),Omega_Gk2(i),w_Gk2(i),...
         M_Gk2(i),e_Gk2(i),a_Gk2(i)] = eci2kep(Y2(i,1:3)',Y2(i,4:6)');
    end
    result = [T2,a_Gk2,e_Gk2,I_Gk2,Omega_Gk2,w_Gk2,M_Gk2];
elseif trigger == "msis"
    % Kepler Elemente msis model
    [T3, Y3] = ode113(@(t,y)odefun_msis(t,y,AdM,t0), tspan, koori, options);
    l3 = length(Y3);
    I_Gk3 = zeros(l3,1);
    e_Gk3 = zeros(l3,1);
    a_Gk3 = zeros(l3,1);
    Omega_Gk3 = zeros(l3,1);
    w_Gk3 = zeros(l3,1);
    M_Gk3 = zeros(l3,1);
    for i=1:length(Y3)
        [I_Gk3(i),Omega_Gk3(i),w_Gk3(i),...
         M_Gk3(i),e_Gk3(i),a_Gk3(i)] = eci2kep(Y3(i,1:3)',Y3(i,4:6)');
    end
    result = [T3,a_Gk3,e_Gk3,I_Gk3,Omega_Gk3,w_Gk3,M_Gk3];
    disp('3 done')
else
    result = [];
end
end