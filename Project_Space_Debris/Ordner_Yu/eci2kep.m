function [I,Omega,w,M,e,a] = eci2kep(ri,vi)
GM = 3.9865005e14;   % m^3/s^2
%
L = cross(ri,vi);
Omega = atan2(L(1), -L(2));
I = atan2(sqrt(L(1)^2 + L(2)^2),L(3));
a = GM * norm(ri) / (2 * GM - norm(ri) * norm(vi)^2);
if 1 - (norm(L)^2 / (GM * a))<0
    e = 0;
else
    e = sqrt(1- norm(L)^2 / (GM*a));
end
rPunkt = dot(ri,vi) / norm(ri);
Ecos = (a - norm(ri)) / (a * e);
Esin = norm(ri) * rPunkt / (e * sqrt(GM * a));
nu = atan2(sqrt(1 - e^2) * Esin,Ecos - e);
E = atan2(Esin,Ecos);
M = E - e * sin(E);
p = R1(I) * R3(Omega) * ri;
w = atan2(p(2), p(1)) - nu;
end

