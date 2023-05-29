function [rangeInPQW] = solveRangeInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly_rad)
semimajor_axis = input('semimajor_axis를 입력하세요: ');  %[km]
eccentricity = input('eccentricity를 입력하세요: ');
true_anomaly_degree = input('true_anomaly를 입력하세요: '); %[degree]

true_anomaly_rad = true_anomaly_degree *pi/180;

n= (eccentricity+cos(true_anomaly_rad))/(1+eccentricity*cos(true_anomaly_rad));
r= semimajor_axis*(1-eccentricity*n);
rangeInPQW = [r * cos(true_anomaly_rad); r * sin(true_anomaly_rad); 0];
end

