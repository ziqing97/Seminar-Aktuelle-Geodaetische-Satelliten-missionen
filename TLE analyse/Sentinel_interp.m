% 
file_S3A = "./data/S3A.tle";
data_S3A = readtle(file_S3A);

file_S3B = "./data/S3B.tle";
data_S3B = readtle(file_S3B);

%% S3A
[~,ia] = unique(data_S3A.time);
data_S3A = data_S3A(ia,:);

t_tick_3A = data_S3A{1,"time"}:0.1:data_S3A{end,"time"};

t_3A = data_S3A{:,"time"};
a_3A = data_S3A{:,"a"};

a_tick_3A = interp1(t_3A,a_3A,t_tick_3A);

figure
hold on
plot(t_3A,a_3A)
plot(t_tick_3A,a_tick_3A)
legend({'origin','after interpolation'})
title("Sentinel-3A")


%% S3B
[~,ia] = unique(data_S3B.time);
data_S3B = data_S3B(ia,:);

t_tick_3B = data_S3B{1,"time"}:0.1:data_S3B{end,"time"};

t_3B = data_S3B{:,"time"};
a_3B = data_S3B{:,"a"};

a_tick_3B = interp1(t_3B,a_3B,t_tick_3B);

figure
hold on
plot(t_3B,a_3B)
plot(t_tick_3B,a_tick_3B)
legend({'origin','after interpolation'})
title("Sentinel-3B")