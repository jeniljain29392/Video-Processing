clc;
clear all;

% video_20_1 = read_avi_file('rgb-20-1.avi', 214, 222, 10);
load('video_25_1.mat');
% [~,~,~,nFrames] = size(video_25_1);
%  
% scaled_vid(:,:,:,1:nFrames) = imresize(video_25_1(:,:,:,1:nFrames), 0.33);

for i=1:2:nFrames-1
% % vstart = 214;  vend = 222;
% % strts = (vstart*6); ends = (vend*6);
% % for i = strts:2:ends;
% %motion_vector = get_motionVector(A(:,:,:,1:2), 3);
%     i
%     vect_25_1(ceil(i/2)) = {get_motionVect_perImg(scaled_vid(:,:,:,i), scaled_vid(:,:,:,i+1), 3)};
% end
% load('temp_vect1.mat');

% [~,nvect] = size(vect_25_1);
% % mean([1;2;3])
% % vect_20_1{2}(2,2)
% % vect_20_1{2}
% for k=1:3:nvect-3
%     for i=1:3
%         for j=1:3
%             vect_1s{ceil(k/3)}(i,j) = mean([vect_25_1{k}(i,j);
%                                      vect_25_1{k+1}(i,j);
%                                      vect_25_1{k+2}(i,j)]);
%         end
%     end
% end

load('vect_25_1_sec.mat');

% [~,n] = size(vect_1s);
% for i=1:n
%    resized_vect(i) = {reshape(vect_1s{i}, [1,9])};
%    feat_vect(i,:) = resized_vect{i};
% end
% 
% IDX = kmeans(feat_vect, 4);
%pause;
%save temp_vect1 vect_20_1;
%save video_20_1.mat video_20_1;
%save vect_20_1.mat vect_20_1;
close all;
