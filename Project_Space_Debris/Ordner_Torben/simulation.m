


%% retrieve file names in correct order


tleFolder = 'D:\uni\Master\Satmis\space junk\gab_dia';
filePattern = fullfile(tleFolder, '*.mat'); % Change to whatever pattern you need.
theFiles = natsortfiles(dir(filePattern));
for i = 1:length(theFiles)
filenames(i,1) = string(theFiles(i).name);
end

%% 

figure

for i = 1:length(filenames)
load(string(tleFolder)+'\'+filenames(i))
for j = 1:length(gab)
    h_apo(j) = gab(j).h_apo;
    h_per(j) = gab(j).h_per;
    period(j) = gab(j).period;
end
scatter(period/60,(h_apo-6378137)/1000,2.5,'b','filled')
hold on
scatter(period/60,(h_per-6378137)/1000,2.5,'r','filled')
legend('Apogäum','Perigäum')
grid on
date = split(erase(erase(filenames(i),'gab'),'.mat'),'_');
mon = month(datetime(str2num(date(1)),str2num(date(2)),1),'name');
mon = string(mon{1});
yea = string(year(datetime(str2num(date(1)),str2num(date(2)),1)));
title(mon+' '+yea)
xlabel('period [min]')
ylabel('height [km]')
%axis([0 2.5e6 0 6e8]);
axis([85 130 0 2e3]);
hold off
drawnow()
clear gab
end

