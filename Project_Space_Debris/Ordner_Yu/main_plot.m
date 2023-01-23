%%
clc;close all;clearvars
files = dir('orbit_data');

%%
starttime = datetime(2022,12,1,0,0,0,'TimeZone','UTC');

t_noforce = [];
a_noforce = [];
e_noforce = [];

t_hp = [];
a_hp = [];
e_hp = [];

t_msis = [];
a_msis = [];
e_msis = [];
for i=1:length(files)
    if files(i).isdir
        continue
    else
        if files(i).name(8:14) == "noforce"
            load([files(i).folder,'/',files(i).name])
            t_noforce = [t_noforce;result_noforce(:,1)];
            a_noforce = [a_noforce;result_noforce(:,2)];
            e_noforce = [e_noforce;result_noforce(:,3)];
        elseif files(i).name(8:9) == "hp"
            load([files(i).folder,'/',files(i).name])
            t_hp = [t_hp;result_harris_priester(:,1)];
            a_hp = [a_hp;result_harris_priester(:,2)];
            e_hp = [e_hp;result_harris_priester(:,3)];
        elseif files(i).name(8:11) == "msis"
            load([files(i).folder,'/',files(i).name])
            t_msis = [t_msis;result_msis(:,1)];
            a_msis = [a_msis;result_msis(:,2)];
            e_msis = [e_msis;result_msis(:,3)];
        end
    end
end
%%
[t_noforce_sorted,I] = sort(t_noforce);
a_noforce_sorted = a_noforce(I);
e_noforce_sorted = e_noforce(I);


[t_hp_sorted,I] = sort(t_hp);
a_hp_sorted = a_hp(I);
e_hp_sorted = e_hp(I);

[t_msis_sorted,I] = sort(t_msis);
a_msis_sorted = a_msis(I);
e_msis_sorted = e_msis(I);
%%
figure
subplot(2,1,1)
hold on
plot(t_noforce_sorted(t_noforce_sorted<24*3600)/3600,(a_noforce_sorted(t_noforce_sorted<24*3600)-6378137)/1000)
plot(t_hp_sorted(t_hp_sorted<24*3600)/3600,(a_hp_sorted(t_hp_sorted<24*3600)-6378137)/1000)
plot(t_msis_sorted/3600,(a_msis_sorted-6378137)/1000)
set(gca,'FontSize',20)
xlabel("time (hour)")
ylabel("a - R (km)")

subplot(2,1,2)
hold on
plot(t_noforce_sorted(t_noforce_sorted<24*3600)/3600,e_noforce_sorted(t_noforce_sorted<24*3600))
plot(t_hp_sorted(t_hp_sorted<24*3600)/3600,e_hp_sorted(t_hp_sorted<24*3600))
plot(t_msis_sorted/3600,e_msis_sorted)
set(gca,'FontSize',20)
xlabel("time (hour)")
ylabel("e")
suptitle("sphere 4.84 m^2, 1250 kg")