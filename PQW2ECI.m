function [RM] = PQW2ECI(arg_prg, inc_angle, RAAN)
 
 %function : Perifocal frame ==> ECI frame (Lesson 07 참고)
 %function 명 : PQW2ECI
 %input : arg_prg, inc_angle, RAAN 
 %output : rotation matrix (3-by-3)

arg_prg = input('argument of perigee값을 입력하세요: ');
inc_angle = input('inclination 값을 입력하세요: ');
RAAN = input('Right Ascension값을 입력하세요: ');

RMz = [cos(arg_prg) sin(arg_prg) 0; -sin(arg_prg) cos(arg_prg) 0; 0 0 1];
RMy = [1 0 0; 0 cos(inc_angle) sin(inc_angle); 0 -sin(inc_angle) cos(inc_angle)];
RMx = [cos(RAAN) sin(RAAN) 0; -sin(RAAN) cos(RAAN) 0; 0 0 1];

RM = RMz*RMy*RMx;


end