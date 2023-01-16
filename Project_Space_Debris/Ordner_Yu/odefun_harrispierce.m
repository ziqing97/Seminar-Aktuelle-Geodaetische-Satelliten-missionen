function dydt =odefun_harrispierce(t, y, AdM, dc)
% Funktion fuer die nummerische Integration von GOCE
% Nadine Sprügel 3317570
% Ziqing Yu 3218051

GM = 3.9865005e14;
h_GOCE = 450 * 1000; % m
f1_GOCE = drag_force_hp(dc,h_GOCE,[y(4);y(5);y(6)],AdM);
dydt=[y(4); 
      y(5);
      y(6);
      -y(1)*GM/norm(y(1:3))^3 + f1_GOCE(1); 
      -y(2)*GM/norm(y(1:3))^3 + f1_GOCE(2); 
      -y(3)*GM/norm(y(1:3))^3 + f1_GOCE(3)];
end