%%
clc;close all;clearvars

%%
path = 'F:\TLE\RESULT\MAT_Year\LEO\leo2022.mat';
load(path)

%% extract data
e = zeros(length(tle_data_leo),1);
a = zeros(length(tle_data_leo),1);

for i=1:length(tle_data_leo)
    data = tle_data_leo(i).data;
    e(i) = data.eccentricity(1);
    a(i) = data.a(1)-6378137;
end


%% took a look
e_sort = sort(e);
figure
plot(e_sort)

a_sort = sort(a);
figure
plot(a_sort)

%% define the class
close all
e_range = 0:0.004:0.028;
a_range = (350:200:800)*1000;
a_range = [140e3,a_range];

ae_mat = nan(length(e_range),length(a_range));
aname = {};
ename = {};
for i = 1:length(e_range)
    if i==1
        index1 = e>=e_range(i) & e<=e_range(i+1);
        ename{i} = [num2str(e_range(i)),'-',num2str(e_range(i+1))];
    elseif i==length(e_range)
        index1 = e>e_range(i);
        ename{i} = ['>',num2str(e_range(i))];
    else
        index1 = e>e_range(i) & e<=e_range(i+1);
        ename{i} = [num2str(e_range(i)),'-',num2str(e_range(i+1))];
    end
    
    for j=1:length(a_range)
        if j==1
            index2 = a>=a_range(j) & a<=a_range(j+1);
            aname{j} = [num2str(a_range(j)/1000),'-',num2str(a_range(j+1)/1000),' km'];
        elseif j==length(a_range)
            index2 = a>a_range(j);
            aname{j} = ['>',num2str(a_range(j)/1000),' km'];
        else
            index2 = a>a_range(j) & a<=a_range(j+1);
            aname{j} = [num2str(a_range(j)/1000),'-',num2str(a_range(j+1)/1000),' km'];
        end
        len = find(index1 & index2);
        ae_mat(i,j) = length(len);
    end
end

figure
ba = bar(ae_mat,'stacked','FaceColor','flat');
xticklabels(ename)
xlabel('eccentricity')
ylabel('count')
set(gca,'FontSize',20)
lgd = legend(aname,'FontSize',16);
lgd.Title.String = 'a - 6371 km';