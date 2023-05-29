function velocityInPQW = solveVelocityInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly_rad)
semimajor_axis = input('semimajor_axis를 입력하세요: ');  %[km]
eccentricity = input('eccentricity를 입력하세요: ');
true_anomaly_degree = input('true_anomaly를 입력하세요: '); %[degree]

true_anomaly_rad = true_anomaly_degree*pi/180;    
mu = 3.986004418 * 10^5; %[km^3/s^2]
    v = sqrt(mu / (semimajor_axis * (1 - eccentricity^2)));
    velocityInPQW = [v * (-sin(true_anomaly_rad)); v * (eccentricity + cos(true_anomaly_rad)); 0];
end