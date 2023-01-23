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

%%
figure
hold on
plot(t_noforce_sorted/3600/24,(a_noforce_sorted-6378137)/1000)
plot(t_hp_sorted/3600/24,(a_hp_sorted-6378137)/1000)
set(gca,'FontSize',20)
xlabel("time (month)")
ylabel("a - R (km)")
pbaspect([3,1,1])

figure
hold on
plot(t_noforce_sorted/3600/24,e_noforce_sorted)
plot(t_hp_sorted/3600/24,e_hp_sorted)
set(gca,'FontSize',20)
xlabel("time (month)")
ylabel("e")
pbaspect([3,1,1])