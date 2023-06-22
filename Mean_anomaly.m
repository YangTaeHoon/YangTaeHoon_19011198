function M = Mean_anomaly(time_start,ntime,a,e,M0)

u = 3.986e+5;
s = seconds(ntime-time_start);

M = M0 + sqrt(u/a^3)*s;

if abs(M) > pi*2
    M = rem(M,pi*2);
end
end