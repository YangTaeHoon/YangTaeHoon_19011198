function velocityInPQW = solveVelocityInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly)
a = semimajor_axis;
e = eccentricity;
v = true_anomaly;
p = a*(1-e^2);
velocityInPQW = sqrt(mu/p)*[-sind(v);e+cosd(v);0];
end