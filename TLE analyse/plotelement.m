function [] = plotelement(data,name,time_split)
xmin = data.time(1) - 60;
xmax = data.time(end) + 60;

time = [data.time(1),time_split,data.time(end)];
legende = cell(length(time)-1,1);
% well, just do some plotting things
fig1 = figure;
subplot(3,1,1)
hold on
for i=1:length(time)-1
    id = data.time>=time(i) & data.time<=time(i+1);
    plot(data.time(id),data.e(id))
    legende{i} = [datestr(datetime(round(time(i)),'ConvertFrom','datenum')),...
        ' --- ',datestr(datetime(round(time(i+1)),'ConvertFrom','datenum'))];
end
title([name,' eccentricity'])
xlabel('Time')
ylabel('Eccentricity')
legend(legende)
set(gca,'FontSize',22)
datetick('x')
xlim([xmin,xmax])

subplot(3,1,3)
hold on
for i=1:length(time)-1
    id = data.time>=time(i) & data.time<=time(i+1);
    plot(data.time(id),data.a(id))
end
title([name,' semi-major axis'])
xlabel('Time')
ylabel('semi-major axis')
set(gca,'FontSize',22)
datetick('x')
xlim([xmin,xmax])

subplot(3,1,2)
hold on
for i=1:length(time)-1
    id = data.time>=time(i) & data.time<=time(i+1);
    plot(data.time(id),data.AoP(id))
end
plot(data.time,ones(length(data.time),1)*90,"LineWidth",2,'color','k')
title([name,' Argument or Perigee'])
xlabel('Time')
ylabel('Argument or Perigee')
set(gca,'FontSize',22)
datetick('x')
xlim([xmin,xmax])

set(gcf,'units','normalized','outerposition',[0 0 1 1])
saveas(fig1,['element_',name],"png")
end