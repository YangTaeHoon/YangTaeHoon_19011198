function az = calculate_azimuth(r_ENU)
    r_E = r_ENU(1);
    r_N = r_ENU(2);
    r_U = r_ENU(3);

    az = rad2deg(acos(r_N / sqrt(r_E^2 + r_N^2)));

    if az < 0
        az = mod(az, 360);
    end
    if r_E >= 0
        az = az;
    else
        az = 360-az;
end