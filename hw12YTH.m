semimajor_axis = input('semimajor_axis를 입력하세요: ');  %[km]
eccentricity = input('eccentricity를 입력하세요: ');
true_anomaly_degree = input('true_anomaly를 입력하세요: '); %[degree]


true_anomaly_rad = true_anomaly_degree *pi/180;

rangeInPQW = solveRangeInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly_rad)
velocityInPQW = solveVelocityInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly_rad)

%%solve r and v in perifocal frame from orbit parameters
%%function 명 : solveRangeInPerifocalFrame, solveVelocityInPerifocalFrame 
%%input : semimajor_axis, eccentricity, true_anomaly  : 3개 scalar 변수
%%output : rangeInPQW, velocityInPQW (unit : km/s) 3-by-1 matrix each, in perifocal coordinate

function [rangeInPQW] = solveRangeInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly_rad)
cosE = (eccentricity+cos(true_anomaly_rad))/(1+eccentricity*cos(true_anomaly_rad));
r= semimajor_axis*(1-eccentricity*cosE);
rangeInPQW = [r * cos(true_anomaly_rad); r * sin(true_anomaly_rad); 0]; %[km]
end

function velocityInPQW = solveVelocityInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly_rad)
   
mu = 3.986004418 * 10^5; %[km^3/s^2]
    v = sqrt(mu / (semimajor_axis * (1 - eccentricity^2)));
    velocityInPQW = [v * (-sin(true_anomaly_rad)); v * (eccentricity + cos(true_anomaly_rad)); 0]; %[km/s]
end

