clc;
clear all;
files = dir('dataset/*.avi');
motion_vector_arr = struct();
motion_vector_arr.name = '';
motion_vector.motionVectors = [];
i = 1;
for file = files'
    videomat = read_avi_file(strcat('dataset/',file.name), 145, 146, 5);
    motion_vector = get_motionVector(videomat(:,:,:,1:2), 3);
    motion_vector_arr(i).name = file.name;
    motion_vector_arr(i).motionVectors = motion_vector;
    i=i+1;
end
%get_motionVect_perImg(videomat(:,:,:,1), videomat(:,:,:,2));
save motion_vector_arr.mat motion_vector_arr;
pause; 
close all;
