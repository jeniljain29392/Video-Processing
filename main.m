clc;
clear all;

videomat = read_avi_file('rgb-03-1.avi', 145, 146, 10);
motion_vector = get_motionVector(videomat(:,:,:,1:2), 3);
%get_motionVect_perImg(videomat(:,:,:,1), videomat(:,:,:,2));

pause;
close all;
