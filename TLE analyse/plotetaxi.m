function [] = plotetaxi(data, name, time_split)
xi = data.e .* cosd(data.AoP);
eta = data.e .* sind(data.AoP);

% time = datetime(data.time,"ConvertFrom","datenum");
% year_change = [];
% year_neu = [];
% colour = ['r', 'g', 'b', 'y', 'c', 'm', 'k'];
% for i = 2:length(time)
%     year = time(i).Year;
%     year_old = time(i-1).Year;
%     if year ~= year_old
%         year_change = [year_change, i-1];
%         year_neu = [year_neu, year_old];
%     end
% end
% year_neu = [year_neu, year];
% j = 1;
% legende = [];
% figure
% year_neu_ge = [];
% year_change_ge = [];
% for i = 1:length(year_change)
%     if year_neu(i) >= year_start
%         year_neu_ge = [year_neu_ge, year_neu(i)];
%         year_change_ge = [year_change_ge, year_change(i)];
%     end
% end
% 
% for i = 1:length(year_change)
%     if ismember(year_change(i),year_change_ge)
%         plot(xi(j:year_change(i)),eta(j:year_change(i)),'color', "r")
%         hold on
%         legende = [legende, string(year_neu(i))];
%     else 
%         plot(xi(j:year_change(i)),eta(j:year_change(i)),'color', "b")
%         hold on
%         legende = [legende, string(year_neu(i))];
%     end
%     j = year_change(i)+1;
% end
% plot(xi(j:end),eta(j:end),'r')

time = [data.time(1),time_split,data.time(end)];
legende = cell(length(time)-1,1);
fig1 = figure;
hold on
for i=1:length(time)-1
    id = data.time>=time(i) & data.time<=time(i+1);
    plot(xi(id),eta(id))
    legende{i} = [datestr(datetime(round(time(i)),'ConvertFrom','datenum')),...
        ' --- ',datestr(datetime(round(time(i+1)),'ConvertFrom','datenum'))];
end

legend(legende)
grid on
title(name)
xlabel('\xi')
ylabel('\eta')
set(gca,'FontSize',32)
set(gcf,'units','normalized','outerposition',[0 0 1 1])
saveas(fig1,['etaxi_',name],"png")
end