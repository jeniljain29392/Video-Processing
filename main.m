clc;
clear all;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read Video file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
video_20_1 = read_avi_file('rgb-20-1.avi', 214, 222, 10);
[~,~,~,nFrames] = size(video_25_1);
scaled_vid(:,:,:,1:nFrames) = imresize(video_25_1(:,:,:,1:nFrames), 0.33);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gets motion vector and 3x3 segmented image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:2:nFrames-1
% % vstart = 214;  vend = 222;
% % strts = (vstart*6); ends = (vend*6);
% % for i = strts:2:ends;
    i
    vect_25_1(ceil(i/2)) = {get_motionVect_perImg(scaled_vid(:,:,:,i), 
                                                scaled_vid(:,:,:,i+1), 3)};
end
% load('temp_vect1.mat');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Take average of 3 frames to get vector for one sec of the video
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,nvect] = size(vect_25_1);
for k=1:3:nvect-3
    for i=1:3
        for j=1:3
            vect_1s{ceil(k/3)}(i,j) = mean([vect_25_1{k}(i,j);
                                     vect_25_1{k+1}(i,j);
                                     vect_25_1{k+2}(i,j)]);
        end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% kmeans clustering of the vectors of the frame
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [~,n] = size(vect_1s);
% for i=1:n
%    resized_vect(i) = {reshape(vect_1s{i}, [1,9])};
%    feat_vect(i,:) = resized_vect{i};
% end
% IDX = kmeans(feat_vect, 4);

close all;
