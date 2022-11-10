function [] = plotelement(data,name)
xmin = data.time(1) - 60;
xmax = data.time(end) + 60;

% well, just do some plotting things
fig1 = figure;
subplot(3,1,1)
plot(data.time,data.e)
title([name,' eccentricity'])
xlabel('Time')
ylabel('Eccentricity')
set(gca,'FontSize',18)
datetick('x')
xlim([xmin,xmax])

subplot(3,1,3)
plot(data.time,data.a)

title([name,' semi-major axis'])
xlabel('Time')
ylabel('semi-major axis')
set(gca,'FontSize',18)
datetick('x')
xlim([xmin,xmax])

subplot(3,1,2)
hold on
plot(data.time,data.AoP)
plot(data.time,ones(length(data.time),1)*90,"LineWidth",2)
title([name,'Argument or Perigee'])
xlabel('Time')
ylabel('Argument or Perigee')
set(gca,'FontSize',18)
datetick('x')
xlim([xmin,xmax])

set(gcf,'units','normalized','outerposition',[0 0 1 1])
saveas(fig1,name,"png")
end