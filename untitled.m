clear;
clc;
close all

%%- function : Perifocal frame ==> ECI frame (Lesson 07 참고)
%%- function 명 : PQW2ECI
%%- input : arg_prg, inc_angle, RAAN 
%%- output : rotation matrix (3-by-3)

function rotation matrix =PQW2ECI[arg_prg, inc_angle, RAAN]

