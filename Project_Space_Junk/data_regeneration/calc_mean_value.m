function data_month_mean = calc_mean_value(data,data_year,data_month)

data = data(year(data.time) == data_year,:);
header = ["inclination","eccentricity","AoP","mean_anomaly","mean_motion","period","a","b"];

month_id = month(data.time) == data_month;

data_split = data(month_id,:);
if size(data_split,1)==0
    meanOfMonth = ones(1,8)*nan;
elseif size(data_split,1)==1
    meanOfMonth = data_split{:,header};
else
    meanOfMonth = mean(data_split{:,header});
end

data_month_mean = array2table(meanOfMonth,"VariableNames",header);
end