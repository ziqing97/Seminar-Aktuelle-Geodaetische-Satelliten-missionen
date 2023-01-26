function rho_atm = density_hp(h)
%%
dc = [100	497400	497400
    120	24900	24900
    130	8377	8710
    140	3899	4059
    150	2122	2215
    160	1263	1344
    170	800.800000000000	875.800000000000
    180	528.300000000000	601
    190	361.700000000000	429.700000000000
    200	255.700000000000	316.200000000000
    210	183.900000000000	239.600000000000
    220	134.100000000000	185.300000000000
    230	99.4900000000000	145.500000000000
    240	74.8800000000000	115.700000000000
    250	57.0900000000000	93.0800000000000
    260	44.0300000000000	75.5500000000000
    270	34.3000000000000	61.8200000000000
    280	26.9700000000000	50.9500000000000
    290	21.3900000000000	42.2600000000000
    300	17.0800000000000	35.2600000000000
    320	10.9900000000000	25.1100000000000
    340	7.21400000000000	18.1900000000000
    360	4.82400000000000	13.3700000000000
    380	3.27400000000000	9.95500000000000
    400	2.24900000000000	7.49200000000000
    420	1.55800000000000	5.68400000000000
    440	1.09100000000000	4.35500000000000
    460	0.770100000000000	3.36200000000000
    480	0.547400000000000	2.61200000000000
    500	0.391600000000000	2.04200000000000
    520	0.281900000000000	1.60500000000000
    540	0.204200000000000	1.26700000000000
    560	0.148800000000000	1.00500000000000
    580	0.109200000000000	0.799700000000000
    600	0.0807000000000000	0.639000000000000
    620	0.0601200000000000	0.512300000000000
    640	0.0451900000000000	0.412100000000000
    660	0.0343000000000000	0.332500000000000
    680	0.0263200000000000	0.269100000000000
    700	0.0204300000000000	0.218500000000000
    720	0.0160700000000000	0.177900000000000
    740	0.0128100000000000	0.145200000000000
    760	0.0103600000000000	0.119000000000000
    780	0.00849600000000000	0.0977600000000000
    800	0.00706900000000000	0.0805900000000000
    840	0.00468000000000000	0.0574100000000000
    880	0.00320000000000000	0.0421000000000000
    920	0.00221000000000000	0.0313000000000000
    960	0.00156000000000000	0.0236000000000000
    1000	0.00115000000000000	0.0181000000000000];

% change the unit
dc(:,1) = dc(:,1) * 1000; % km to m
dc(:,2:3) = dc(:,2:3) / 1000^4; % g/km^3 to kg/m^3

% find the precise altitude intervall
idx = find(h>dc(:,1));
if (h>=1000000)
    rho_min = dc(50,2);
    rho_max = dc(50,3);
elseif (h<=100000)
    rho_min = dc(1,2);
    rho_max = dc(1,3);
else
    if (dc(max(idx)) ~= h)
        idx = max(idx);
        % According to the Harris-Priester Density Model
        H_min = (dc(idx,1) - dc(idx+1,1)) / (log(dc(idx+1,2) / dc(idx,2)));
        H_max = (dc(idx,1) - dc(idx+1,1)) / (log(dc(idx+1,3) / dc(idx,3)));

        rho_min = dc(idx,2) * exp((dc(idx,1) - h) / H_min);
        rho_max = dc(idx,3) * exp((dc(idx,1) - h) / H_max);
    else
        idx = max(idx)+1;
        rho_min = dc(idx,2);
        rho_max = dc(idx,3);
    end
end

% A simplified estimation for atmospheric density
rho_atm = (rho_min + rho_max) / 2;
end