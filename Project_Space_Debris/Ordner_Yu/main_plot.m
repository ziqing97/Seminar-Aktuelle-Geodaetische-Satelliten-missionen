%%
clc;close all;clearvars
files = dir('orbit_data_1');

%%
starttime = datetime(2022,12,1,0,0,0,'TimeZone','UTC');

t_noforce = [];
a_noforce = [];
e_noforce = [];
I_noforce = [];
Omega_noforce = [];
w_noforce = [];
M_noforce = [];

t_hp = [];
a_hp = [];
e_hp = [];
I_hp = [];
Omega_hp = [];
w_hp = [];
M_hp = [];

t_msis = [];
a_msis = [];
e_msis = [];
I_msis = [];
Omega_msis = [];
w_msis = [];
M_msis = [];
for i=1:length(files)
    if files(i).isdir
        continue
    else
        if files(i).name(8:14) == "noforce"
            load([files(i).folder,'/',files(i).name])
            t_noforce = [t_noforce;result_noforce(:,1)];
            a_noforce = [a_noforce;result_noforce(:,2)];
            e_noforce = [e_noforce;result_noforce(:,3)];
            I_noforce = [I_noforce;result_noforce(:,4)];
            Omega_noforce = [Omega_noforce;result_noforce(:,5)];
            w_noforce = [w_noforce;result_noforce(:,6)];
            M_noforce = [M_noforce;result_noforce(:,7)];
        elseif files(i).name(8:9) == "hp"
            load([files(i).folder,'/',files(i).name])
            t_hp = [t_hp;result_harris_priester(:,1)];
            a_hp = [a_hp;result_harris_priester(:,2)];
            e_hp = [e_hp;result_harris_priester(:,3)];
            I_hp = [I_hp;result_harris_priester(:,4)];
            Omega_hp = [Omega_hp;result_harris_priester(:,5)];
            w_hp = [w_hp;result_harris_priester(:,6)];
            M_hp = [M_hp;result_harris_priester(:,7)];
        elseif files(i).name(8:11) == "msis"
            load([files(i).folder,'/',files(i).name])
            t_msis = [t_msis;result_msis(:,1)];
            a_msis = [a_msis;result_msis(:,2)];
            e_msis = [e_msis;result_msis(:,3)];
            I_msis = [I_msis;result_msis(:,4)];
            Omega_msis = [Omega_msis;result_msis(:,5)];
            w_msis = [w_msis;result_msis(:,6)];
            M_msis = [M_msis;result_msis(:,7)];
        end
    end
end
%%
[t_noforce_sorted,index] = sort(t_noforce);
a_noforce_sorted = a_noforce(index);
e_noforce_sorted = e_noforce(index);
I_noforce_sorted = I_noforce(index);
Omega_noforce_sorted = w_noforce(index);
w_noforce_sorted = w_noforce(index);
M_noforce_sorted = M_noforce(index);

[t_hp_sorted,index] = sort(t_hp);
a_hp_sorted = a_hp(index);
e_hp_sorted = e_hp(index);
I_hp_sorted = I_hp(index);
Omega_hp_sorted = Omega_hp(index);
w_hp_sorted = w_hp(index);
M_hp_sorted = M_hp(index);

[t_msis_sorted,index] = sort(t_msis);
a_msis_sorted = a_msis(index);
e_msis_sorted = e_msis(index);
I_msis_sorted = I_msis(index);
Omega_msis_sorted = Omega_msis(index);
w_msis_sorted = w_msis(index);
M_msis_sorted = M_msis(index);

%%
lla_noforce = zeros(length(t_noforce_sorted),3);
for i=1:length(t_noforce_sorted)
t_matlab = starttime + t_noforce_sorted(i)/3600/24;
lla_noforce(i,:) = kep2lla(a_noforce_sorted(i),e_noforce_sorted(i), ...
    I_noforce_sorted(i),Omega_noforce_sorted(i),w_noforce_sorted(i), ...
    M_noforce_sorted(i),t_matlab);
end

lla_hp_sorted = zeros(length(t_hp_sorted),3);
for i=1:length(t_hp_sorted)
t_matlab = starttime + t_hp_sorted(i)/3600/24;
lla_hp_sorted(i,:) = kep2lla(a_hp_sorted(i),e_hp_sorted(i), ...
    I_hp_sorted(i),Omega_hp_sorted(i),w_hp_sorted(i), ...
    M_hp_sorted(i),t_matlab);
end

lla_msis_sorted = zeros(length(t_msis_sorted),3);
for i=1:length(t_msis_sorted)
t_matlab = starttime + t_msis_sorted(i)/3600/24;
lla_msis_sorted(i,:) = kep2lla(a_msis_sorted(i),e_msis_sorted(i), ...
    I_msis_sorted(i),Omega_msis_sorted(i),w_msis_sorted(i), ...
    M_msis_sorted(i),t_matlab);
end

%% 
figure
subplot(2,1,1)
hold on
plot(t_noforce_sorted/3600/24,a_noforce_sorted/1000)
plot(t_hp_sorted/3600/24,a_hp_sorted/1000)
plot(t_msis_sorted/3600/24,a_msis_sorted/1000)
set(gca,'FontSize',14)
xlabel("time (day)")
ylabel("a (km)")
legend({'no air force','with harris-priester model','with msis00 model'})

subplot(2,1,2)
hold on
plot(t_noforce_sorted/3600/24,e_noforce_sorted)
plot(t_hp_sorted/3600/24,e_hp_sorted)
plot(t_msis_sorted/3600/24,e_msis_sorted)
set(gca,'FontSize',14)
xlabel("time (day)")
ylabel("e")
legend({'no air force','with harris-priester model','with msis00 model'})
tsz=sgtitle("sphere 4.84 m^2, 1250 kg, T=0.95 hour, cd=1");
tsz.FontSize=20;


