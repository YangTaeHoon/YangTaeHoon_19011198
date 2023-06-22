clear;
clc;
close all;


%%% input %%%
ground_lat = input('groundstation의 위도를 입력하세요: ');
ground_lon = input('groundstation의 경도를 입력하세요: ');
height = input('groundstation의 고도를 입력하세요: ');
el_mask = input('위성고도각을 입력하세요: ');

%%% 시작시간 %%%%
starttime = datetime(2023, 5, 9, 2, 0, 0);

%%% 다음날 자정 설정 %%%
nextday = starttime + days(1) - minute(120); %QZSS의 경우 주어진 시각이 2시임을 반영.

%%% 다음날 자정을 종료시간으로 설정 %%%
stoptime = datetime(nextday);

%%% 매개변수 %%%
load('nav.mat');
a = nav.QZSS.a/1000; % Semi-major-axis [km]
e = nav.QZSS.e; %eccentricity
i = rad2deg(nav.QZSS.i); %inclination [deg]
w = rad2deg(nav.QZSS.omega); %argument of perigee [deg]
M0 = nav.QZSS.M0; %Mean Anomaly [rad]
toc = nav.QZSS.toc; %특정 시간
W = rad2deg(nav.QZSS.OMEGA); %Right ascension of the ascending node [deg]


% 시간 범위 설정
term=datetime(toc);
first_midnight = datetime(starttime);
second_midnight = datetime(stoptime);
time = linspace(first_midnight, second_midnight, 24 * 60);

% 위도, 경도, 방위각, 고도각을 행렬로 선언
lat_geoplot = zeros(1,numel(time));
lon_geoplot = zeros(1,numel(time));
az_skyplot = zeros(1,numel(time));
el_skyplot = zeros(1,numel(time));


%%% calculate %%%
for idx = 1:numel(time)
    %% Flight time으로 시간에 따른 Mean motion 구하기
    M = Mean_anomaly(term, time(idx), a, e, M0);
    %% 수치해석으로 Eccentric anomaly 구하기 
    E = solve_eccentric_anomaly(M, e);
    %% atan2로 v값 구하기
    v = Eccentric_Anomaly2True_Anomaly(E, e);
    %% PQW좌표계상에 나타내기 [rcosv; rsinv; 0]
    r_PQW = solveRangeInPerifocalFrame(a, e, v);
    %% Perifocal에서 ECI좌표계로 가는 DCM구하기 (DCM = R3(W)*R1(i)*R3(w))
    DCM_Perifocal2Inertial = PQW2ECI(w, i, W);
    r_ECI = DCM_Perifocal2Inertial * r_PQW;
    %% ECI에서 ECEF좌표계로 가는 DCM구하기 (DCM = R3(GMST))
    DCM = ECI2ECEF_DCM(time(idx));
    r_ECEF = DCM * r_ECI;
    %%지구 타원체
    wgs84 = wgs84Ellipsoid('kilometer');
    [lat, lon, h] = ecef2geodetic(wgs84, r_ECEF(1), r_ECEF(2), ...
        r_ECEF(3), "degrees");
    lat_geoplot = [lat_geoplot, lat];
    lon_geoplot = [lon_geoplot, lon];
    [r_ENU(1), r_ENU(2), r_ENU(3)] = ecef2enu(r_ECEF(1), ...
        r_ECEF(2), r_ECEF(3), ground_lat, ground_lon, height, wgs84);
    r_ENU = [r_ENU(1); r_ENU(2); r_ENU(3)];
    az = calculate_azimuth(r_ENU);
    el = calculate_elevation(r_ENU, el_mask);
    az_skyplot = [az_skyplot, az];
    el_skyplot = [el_skyplot, el];
end 

%%% 음수인 고도각 %%%
el(el < 0) = missing  

%%% geoplot, skyplot %%%
geoplot(lat_geoplot, lon_geoplot, 'm-*');
figure;
skyplot(az_skyplot, el_skyplot);

%%% 위성 궤도 %%% 
sampleTime = 60;
sc = satelliteScenario(starttime,stoptime,sampleTime);
gs = groundStation(sc,lat,lon);

semiMajorAxis = 42164000;
eccentricity = e;
inclination = i;
rightAscensionOfAscendingNode = W;
argumentOfPeriapsis = w;
trueAnomaly = v;
sat = satellite(sc,semiMajorAxis,eccentricity,inclination, ...
    rightAscensionOfAscendingNode,argumentOfPeriapsis,trueAnomaly)

show(sat)
groundTrack(sat,LeadTime=3600)
ac = access(sat,gs);
play(sc,PlaybackSpeedMultiplier=40)