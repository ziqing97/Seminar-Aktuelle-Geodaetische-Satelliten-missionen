clc;close all;clearvars
%%
information = import_other_statistic("E:\OneDrive\Studium\M5-AktuelleGeodaetischeSatellitenmissionen\Seminar-Aktuelle-Geodaetische-Satelliten-missionen\Project_Space_Debris\Ordner_Yu\object_count\2022information.csv", [2, Inf]);

objectClass = information.objectClass;
Classtype = unique(objectClass);

class_count = zeros(length(Classtype),1);
for i=1:length(class_count)
    index = (objectClass == Classtype(i));
    class_count(i) = length(find(index));
end
Classtype = Classtype(2:12);
class_count(end) = class_count(end) + class_count(1);
class_count = class_count(2:12);

figure
bar(class_count)
xticklabels(Classtype)
xlabel('Object type')
ylabel('Count')
title('Space objects type in 2022')
set(gca,'FontSize',24)

%%
avg_AdM = information.xSectAvg ./ information.mass;
avg_AdM_valid = avg_AdM(~isnan(avg_AdM));
avg_AdM_valid = sort(avg_AdM_valid);

range = 0:0.01:0.07;
range = [range,7];
adm_count = zeros(length(range)-1,1);
adm_name = {};
for i=1:length(range)-1
    if i==1
        index = avg_AdM_valid>=range(i) & avg_AdM_valid<=range(i+1);
    else
        index = avg_AdM_valid>range(i) & avg_AdM_valid<=range(i+1);
    end
    adm_count(i) = length(find(index));
    adm_name{i} = [num2str(range(i)),'-',num2str(range(i+1))];
end
adm_name{end} = '>0.07';
figure
bar(adm_count)
xticklabels(adm_name)
xlabel('AdM range[m^2/kg]')
ylabel('Count')
title('Space objects AdM distribution in 2022')
set(gca,'FontSize',24)