clc;
clear all;

%videomat = read_avi_file('rgb-04-1.avi', 145.5, 148, 10);
load('videomat.mat', 'videomat');
[ a, b, c, nFrames] = size(videomat);
A(:,:,:,1:nFrames) = imresize(videomat(:,:,:,1:nFrames), 0.33);

for i=1:nFrames-1
%motion_vector = get_motionVector(A(:,:,:,1:2), 3);
    vect = get_motionVect_perImg(A(:,:,:,i), A(:,:,:,i+1), 3);
    pause;
end
pause;
%save videomat.mat videomat;
close all;
