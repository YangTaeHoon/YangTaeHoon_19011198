function DCM=ECI2ECEF_DCM(time)
jd = juliandate(time);
GMST = siderealTime(jd);

DCM = [cosd(GMST) sind(GMST) 0;
       -sind(GMST) cosd(GMST) 0;
       0 0 1];

end