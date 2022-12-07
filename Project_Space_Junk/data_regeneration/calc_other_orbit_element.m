function tle_data = calc_other_orbit_element(tle_data)
% transform unixtime to matlab datetime and 
% calculate semi-axis, period.

% unix time to matlab datetime
tle_data.time = datetime(tle_data.time,'convertfrom','epochtime');
if tle_data.time>datetime(2023,1,1)
    tle_data.time = tle_data.time-years(100);
end
% period
tle_data.period = 86164.091./tle_data.mean_motion;
% semi-major axis
tle_data.a = ((tle_data.period./(2*pi)).^2.*398.6e12).^(1/3);
% semi-minor axis
tle_data.b = tle_data.a.*sqrt(1-tle_data.eccentricity.^2);
% sort by time
tle_data = sortrows(tle_data,'time');
end
