function [] = compare_timeseries_sentinel(data_list,name_list,commossion_time)
% 

% get the x limit
xmax = 0;
xmin = 1e50;
for j=1:length(data_list)
    if  data_list{j}.time(1)<xmin
        xmin = data_list{j}.time(1);
    end
    if data_list{j}.time(end)>xmax
        xmax = data_list{j}.time(end);
    end
end
xmin = xmin - 60;
xmax = xmax + 60;

% get the title
name ='';
for i=1:length(name_list)
    name = [name,',',name_list{i}];
end
name = name(2:end);

% well, just do some plotting things
fig1 = figure;

% e
subplot(3,1,1)
hold on
for j=1:length(data_list)
    id = data_list{j}.time>commossion_time(j);
    plot(data_list{j}.time(id),data_list{j}.e(id))
end
title([name,' eccentricity'])
ylabel('Eccentricity','FontSize',2)
legend(name_list)
set(gca,'FontSize',16)
datetick('x')
grid on
xlim([xmin,xmax])

% height
subplot(3,1,3)
hold on
for j=1:length(data_list)
    id = data_list{j}.time>commossion_time(j);
    plot(data_list{j}.time(id),data_list{j}.a(id)/1000-6371)
end
title([name,' height'])
xlabel('Time')
ylabel('height [km]')
set(gca,'FontSize',16)
datetick('x')
grid on
xlim([xmin,xmax])

% AoP
subplot(3,1,2)
hold on
for j=1:length(data_list)
    id = data_list{j}.time>commossion_time(j);
    plot(data_list{j}.time(id),data_list{j}.AoP(id))
end
plot([xmin,xmax],ones(2,1)*90,"LineWidth",2,'color','k') % plot the 90 degree line
title([name,' Argument of Perigee'])
ylabel('Argument of Perigee [°]')
set(gca,'FontSize',16)
datetick('x')
grid on
yticks(0:45:315)
xlim([xmin,xmax])


% save the plot
set(gcf,'units','normalized','outerposition',[0 0 1 1])
saveas(fig1,['img/element_',name],"png")
end
