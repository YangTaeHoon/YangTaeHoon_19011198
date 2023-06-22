function rangeInPQW = solveRangeInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly)
a = semimajor_axis;
e = eccentricity;
v = true_anomaly;
p = a*(1-e^2);
r = p/(1+e*cosd(v));
rangeInPQW = [r*cosd(v);r*sind(v);0];
end
