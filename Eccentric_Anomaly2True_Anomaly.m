function v = Eccentric_Anomaly2True_Anomaly(E,e)
sinv = sqrt(1 - e^2) * sin(E) / (1 - e * cos(E));
cosv = (cos(E) - e) / (1 - e * cos(E));
true_anomaly = atan2(sinv, cosv);
v = rad2deg(true_anomaly);
end

 