clc;
clear all;

% video_20_1 = read_avi_file('rgb-20-1.avi', 214, 222, 10);
% load('video_20_1.mat');
% [ a, b, c, nFrames] = size(video_20_1);
%  
% scaled_vid(:,:,:,1:nFrames) = imresize(video_20_1(:,:,:,1:nFrames), 0.33);
% 
% % for i=1:nFrames-1
% vstart = 214;  vend = 222;
% strts = (vstart*6); ends = (vend*6);
% for i = strts:2:ends;
% %motion_vector = get_motionVector(A(:,:,:,1:2), 3);
%     vect_20_1(ceil((i-strts+1)/2)) = {get_motionVect_perImg(scaled_vid(:,:,:,i), scaled_vid(:,:,:,i+1), 3)};
% end
load('temp_vect1.mat');

[~,nvect] = size(vect_20_1);
% mean([1;2;3])
% vect_20_1{2}(2,2)
% vect_20_1{2}
for k=1:3:nvect-3
    for i=1:3
        for j=1:3
            1s_vect{ceil(k/3)}(i,j) = mean([vect_20_1{k}(i,j);
                                     vect_20_1{k+1}(i,j);
                                     vect_20_1{k+2}(i,j)]);
        end
    end
end

%pause;
%save temp_vect1 vect_20_1;
%save video_20_1.mat video_20_1;
%save vect_20_1.mat vect_20_1;
close all;
