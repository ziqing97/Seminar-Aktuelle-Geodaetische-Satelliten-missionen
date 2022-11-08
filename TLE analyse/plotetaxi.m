function [] = plotetaxi(data)
xi = data.e .* cosd(data.mean_anomaly);
eta = data.e .* sind(data.mean_anomaly);

figure
plot(xi,eta)
end