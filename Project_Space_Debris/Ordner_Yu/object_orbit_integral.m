function [] = object_orbit_integral(e,AdM,a)

I = deg2rad(98.622);         % radiant
Omega = deg2rad(335);   % radiant
w = deg2rad(273);       % radiant
M = deg2rad(5);         % radiant


%%
starttime = datetime(2023,1,1,0,0,0,'TimeZone','UTC');
tspan = 0:24*3600:24*3600*365*40; % integral time
folder = ['E:/orbit/orbit_e_',num2str(e),'_AdM_',num2str(AdM)];
if ~exist(folder,'dir')
    mkdir(folder)
end
for i=1:length(tspan)-1
    tspan_split=[tspan(i),tspan(i+1)];
    t0 = starttime+tspan(i)/3600/24;
    if i==1
    result_harris_priester = orbit_integral(a,e,I,Omega,...
        w,M,AdM,t0,tspan_split,"hp");
    else
    % harris-priester model
    a = result_harris_priester(end,2);      % meter
    e = result_harris_priester(end,3);      % radiant
    I = result_harris_priester(end,4);
    Omega = result_harris_priester(end,5);   % radiant
    w = result_harris_priester(end,6);       % radiant
    M = result_harris_priester(end,7);       % radiant
    if (a + a * e) < 6378137 + 150e3
        break
    end
    result_harris_priester = orbit_integral(a,e,I,Omega,...
        w,M,AdM,t0,tspan_split,"hp");
    end
    name = [folder,'/result_hp_',num2str(i),'.mat'];
    save(name,'result_harris_priester')
end
disp(folder)

end