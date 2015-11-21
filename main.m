clc;
clear all;

video_04_1 = read_avi_file('rgb-04-1.avi', [], [], 10);
%load('videomat.mat', 'videomat');
[ a, b, c, nFrames] = size(video_04_1);
scaled_vid(:,:,:,1:nFrames) = imresize(video_04_1(:,:,:,1:nFrames), 0.33);

for i=1:nFrames-1
%motion_vector = get_motionVector(A(:,:,:,1:2), 3);
    vect_04_1(i) = {get_motionVect_perImg(scaled_vid(:,:,:,i), scaled_vid(:,:,:,i+1), 3)};
end
pause;
save video_04_1.mat video_04_1
save vect_04_1.mat vect_04_1;
close all;
