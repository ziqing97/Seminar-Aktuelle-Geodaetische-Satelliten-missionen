function [] = plotetaxi(data, name, time_split)

% calculate the both elements
xi = data.e .* cosd(data.AoP);
eta = data.e .* sind(data.AoP);

% split the timeseries into several phases
time = [data.time(1),time_split,data.time(end)];
legende = cell(length(time)-1,1);

% plot
fig1 = figure;
hold on
for i=1:length(time)-1
    id = data.time>=time(i) & data.time<=time(i+1);
    plot(xi(id),eta(id))
    legende{i} = [datestr(datetime(round(time(i)),'ConvertFrom','datenum')),...
        ' --- ',datestr(datetime(round(time(i+1)),'ConvertFrom','datenum'))];
end
axis equal;
legend(legende)
grid on
title(name)
xlabel('\xi')
ylabel('\eta')
set(gca,'FontSize',16)
set(gcf,'units','normalized','outerposition',[0 0 1 1])

% save the plots
saveas(fig1,['img/etaxi_',name],"png")
end
