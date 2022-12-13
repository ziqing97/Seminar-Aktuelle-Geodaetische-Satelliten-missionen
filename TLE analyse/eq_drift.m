function [] = eq_drift(data, r_p, startup_ind, name)
    id = data.time>startup_ind;
    a = data.a(id);
    t = data.time(id);
    dx = diff(a).*diff(t)*9*r_p;

    figure
    subplot(3,1,2)
    plot(t(1:length(t)-1),dx/1000)
    title([name,' Orbit Drift at Equator (dx)'])
    datetick('x')
    ylabel('Orbit Drift change [km]')
    
    subplot(3,1,1)
    plot(t,a-6371000-796000)
    ylabel('Höhe-796km [m]')
    datetick('x')
    title([name,' Height'])
    subplot(3,1,3)
    plot(t(1:length(t)-1), cumsum(dx)/1000)
    ylabel('Orbit Drift [km]')
    xlabel('Time')
    datetick('x')
    title([name,' Absolut Orbit Drift from Equator (x)'])
end