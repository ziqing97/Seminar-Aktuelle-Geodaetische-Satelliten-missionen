clc;close all;clearvars
%%
information = import_other_statistic("2022information.csv", [2, Inf]);

%% object classification: 26885 in total
objectClass = information.objectClass;
objectClass(objectClass=='') = 'Unknown';
Classtype = unique(objectClass);

class_count = zeros(length(Classtype),1);
for i=1:length(class_count)
    index = (objectClass == Classtype(i));
    class_count(i) = length(find(index));
end

figure
bar(class_count)
xticklabels(Classtype)
xlabel('Object class')
ylabel('Count')
title('Space objects classification in 2022')
set(gca,'FontSize',24)

%% object classification and AdM
% 12472 in total because not all objects have area/mass data

% do the filtering
objectClass = information.objectClass;
objectClass(objectClass=='') = 'Unknown';
Classtype = unique(objectClass);
avg_AdM = information.xSectAvg ./ information.mass;

avg_AdM_valid = avg_AdM(~isnan(avg_AdM));
objectClass = objectClass(~isnan(avg_AdM));
[avg_AdM_valid,id] = sort(avg_AdM_valid);
objectClass = objectClass(id);

% get class type
class_count = zeros(length(Classtype),1);
for i=1:length(class_count)
    index = (objectClass == Classtype(i));
    class_count(i) = length(find(index));
end

range = 0:0.01:0.07;
adm_count = zeros(length(range),length(class_count));
adm_name = {};

% count using loop
for i=1:length(range)
    for j=1:length(class_count)
        index1 = (objectClass == Classtype(j));
        if i==1
            index2 = avg_AdM_valid>=range(i) & avg_AdM_valid<=range(i+1) & index1;
        elseif (i == length(range)) 
            index2 = avg_AdM_valid>range(i) & index1;
        else
            index2 = avg_AdM_valid>range(i) & avg_AdM_valid<=range(i+1)& index1;
        end
        adm_count(i,j) = length(find(index2));
        if i == length(range)
            adm_name{i} = '>0.07';
        else
            adm_name{i} = [num2str(range(i)),'-',num2str(range(i+1))];
        end
    end
end

% plot
figure
ba = bar(adm_count,'stacked','FaceColor','flat');
ba(1).CData = [0 0 128]/255;
ba(2).CData = [0 238 0]/255;
ba(10).CData = [255 0 0]/255;
ba(4).CData = [255 106 106]/255;
xticklabels(adm_name)
xlabel('Area mass ratio range[m^2/kg]','FontSize',24)
ylabel('Count','FontSize',24)
title(['Space objects area mass ratio distribution in 2022' ...
    ' (for 12472 objects)'],'FontSize',24)
set(gca,'FontSize',24)
legend(Classtype,'FontSize',10)
