function [] = plotelement(data,name,time_split)

% get the xlimits
xmin = data.time(1) - 60;
xmax = data.time(end) + 60;

% time for different phases
time = [data.time(1),time_split,data.time(end)];
legende = cell(length(time)-1,1);

% well, just do some plotting things
fig1 = figure;

% e
subplot(3,1,1)
hold on
for i=1:length(time)-1
    id = data.time>=time(i) & data.time<=time(i+1);
    plot(data.time(id),data.e(id))
    legende{i} = [datestr(datetime(round(time(i)),'ConvertFrom','datenum')),...
        ' --- ',datestr(datetime(round(time(i+1)),'ConvertFrom','datenum'))];
end
title([name,' eccentricity'])
ylabel('Eccentricity','FontSize',2)
legend(legende)
set(gca,'FontSize',16)
datetick('x')
grid on
xlim([xmin,xmax])

% height
subplot(3,1,3)
hold on
for i=1:length(time)-1
    id = data.time>=time(i) & data.time<=time(i+1);
    plot(data.time(id),data.a(id)/1000-6371)
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
for i=1:length(time)-1
    id = data.time>=time(i) & data.time<=time(i+1);
    plot(data.time(id),data.AoP(id))
end
plot(data.time,ones(length(data.time),1)*90,"LineWidth",2,'color','k')
title([name,' Argument of Perigee'])
ylabel('Argument of Perigee [°]')
yticks([0 90 180 270 360])
set(gca,'FontSize',16)
datetick('x')
grid on
yticks(0:45:360)
xlim([xmin,xmax])

set(gcf,'units','normalized','outerposition',[0 0 1 1])
saveas(fig1,['img/element_',name],"png")
end
