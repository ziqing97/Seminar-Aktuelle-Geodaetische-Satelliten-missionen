function dydt =odefun_noforce(t,y)
% Funktion für die nummerische Integration von GOCE
% Nadine Sprügel 3317570
% Ziqing Yu 3218051

% Constant
GM = 3.9865005e14;

%
ri = y(1:3);
vi = y(4:6);

% 
dydt=[vi(1); 
      vi(2);
      vi(3);
      -ri(1) * GM/norm(ri)^3
      -ri(2) * GM/norm(ri)^3
      -ri(3) * GM/norm(ri)^3];
end