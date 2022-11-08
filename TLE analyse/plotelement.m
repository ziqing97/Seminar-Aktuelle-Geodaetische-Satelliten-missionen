function [] = plotelement(data,name)
% well, just do some plotting things
figure
subplot(3,2,1)
plot(data.time,data.e)
title([name,' eccentricity'])
xlabel('Time')
ylabel('Eccentricity')
datetick('x')

subplot(3,2,2)
plot(data.time,data.a)
title([name,' semi-major axis'])
xlabel('Time')
ylabel('semi-major axis')
datetick('x')

subplot(3,2,3)
plot(data.time,data.b)
title([name,' semi-minor axis'])
xlabel('Time')
ylabel('semi-minor axis')
datetick('x')

subplot(3,2,4)
plot(data.time,data.inclination)
title([name,' inclination'])
xlabel('Time')
ylabel('inclination')
datetick('x')

subplot(3,2,5)
hold on
plot(data.time,data.mean_anomaly)
plot(data.time,ones(length(data.time),1)*270)
title([name,' mean anomaly'])
xlabel('Time')
ylabel('mean_anomaly')
datetick('x')

subplot(3,2,6)
plot(data.time,data.mean_motion)
title([name,' mean motion'])
xlabel('Time')
ylabel('mean motion')
datetick('x')
end