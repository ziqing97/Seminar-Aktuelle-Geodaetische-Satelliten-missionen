function [ri,vi] = kep2eci(I,Omega,w,Mt,e,a,GM)

E0 = Mt;
Ek = Mt + e * sin(E0);
while abs(E0 - Ek) > 1e-12
    E0 = Ek;
    Ek = Mt + e * sin(E0);
end
E = Ek;
n = sqrt(GM/a^3);


rf = [a*(cos(E(1))-e); a*sqrt(1-e^2)*sin(E(1)); 0];
vf = n * a/(1-e*cos(E(1))) * [-sin(E(1)); sqrt(1-e^2)*cos(E(1)); 0];

ri = R3(-Omega) * R1(-I) * R3(-w) * rf;
vi = R3(-Omega) * R1(-I) * R3(-w) * vf;
end

