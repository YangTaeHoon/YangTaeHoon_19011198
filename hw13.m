%%input
t = input('시간을 입력하시오. [YYYY,MM,DD,hh,mm,ss] '); 
el_mask = input('Elevation Mask를 입력하시오. [deg] ');
n = input('행의 개수를 입력하시오.') ;

ENU = zeros(n, 3);
Rrel = zeros(n, 1);
Az_rad = zeros(n, 1);
El_rad = zeros(n, 1);

for i = 1:n
    ENU(i, 1) = input('e 값을 입력하세요: ');
    ENU(i, 2) = input('n 값을 입력하세요: ');
    ENU(i, 3) = input('u 값을 입력하세요: ');

    Rrel(i) = sqrt(ENU(i, 1)^2 + ENU(i, 2)^2 + ENU(i, 3)^2); %[km]
    Az_rad(i) = acos(ENU(i, 2) / sqrt(ENU(i, 1)^2 + ENU(i, 2)^2)); %[rad]
    El_rad(i) = asin(ENU(i, 3) / Rrel(i)); %[rad]
end


disp('입력된 행렬:');
disp(ENU);

% Coordinate Transform Functions

function DCM = ECI2ECEF_DCM(time)
    time_zero = datetime(2000, 1, 1, 12, 0, 0); % Universal Time의 기준점 (2000년 1월 1일 12시 0분 0초)
    jd = juliandate(time_zero);
    theta_g0 = siderealtime(jd);
    delta_t = seconds(time - time_zero);
    w_earth = 7.27*10^-5; % 지구의 회전 속도 (rad/s)

    theta_g_rad = w_earth * delta_t + theta_g0;
    theta_g = rad2deg(theta_g_rad);

    DCM = [cosd(theta_g) sind(theta_g) 0; -sind(theta_g) cosd(theta_g) 0; 0 0 1];
    disp(' ECI to ECEF DCM : ');
    disp(DCM)
end


%Elevation, azimuth angle calculator

% Azimuth Angle

function Az = azimuth(ENU)

Az = rad2deg(Az_rad);

disp(' Azimuth Angle ( deg ) : ');
disp(Az);
end

%Elevation Angle

function el = elevation(ENU, el_mask);

el = rad2deg(El_rad);
el_mask_deg = el_mask * 180 / pi ;

if el > el_mask_deg
    disp(' Elevation Angle (deg) : ');
    disp(el);
else
    disp(' NaN ');
end


end


