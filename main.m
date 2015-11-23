clc;
clear all;


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Read Video file
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% video_20_1 = read_avi_file('rgb-20-1.avi', 214, 222, 10);
% [~,~,~,nFrames] = size(video_25_1);
% scaled_vid(:,:,:,1:nFrames) = imresize(video_25_1(:,:,:,1:nFrames), 0.33);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Gets motion vector and 3x3 segmented image.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i=1:2:nFrames-1
% % % vstart = 214;  vend = 222;
% % % strts = (vstart*6); ends = (vend*6);
% % % for i = strts:2:ends;
%     i
%     vect_25_1(ceil(i/2)) = {get_motionVect_perImg(scaled_vid(:,:,:,i), 
%                                                 scaled_vid(:,:,:,i+1), 3)};
% end
% % load('temp_vect1.mat');
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Take average of 3 frames to get vector for one sec of the video
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [~,nvect] = size(vect_25_1);
% for k=1:3:nvect-3
%     for i=1:3
%         for j=1:3
%             vect_1s{ceil(k/3)}(i,j) = mean([vect_25_1{k}(i,j);
%                                      vect_25_1{k+1}(i,j);
%                                      vect_25_1{k+2}(i,j)]);
%         end
%     end
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% kmeans clustering of the vectors of the frame
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [~,n] = size(vect_1s);
% for i=1:n
%    resized_vect(i) = {reshape(vect_1s{i}, [1,9])};
%    feat_vect(i,:) = resized_vect{i};
% end
% IDX = kmeans(feat_vect, 4);

load('IDX.mat')
IDX = ans;
splitout = splitVideo(IDX);

load('vect_25_1_sec.mat')
 
k = 1;
for i=1:size(splitout,2)-1
   fstart = splitout(i);
   fend = splitout(i+1);
   if (fend - fstart)>=5
       for j = fstart:fend
           avg_seq(j,:) = reshape(vect_1s{j}, [1, 9]);
       end
       output_seq(k) = struct('frame', reshape(mean(avg_seq(fstart:fend, :)),[3,3]),...
                    'fstart', fstart, 'fend', fend, 'eucli_dist', []);
       k = k + 1;
       clear seq;
   end
end

k = 1;
istart = 269;
iend = 278;
for j = istart:iend
   input_seq(j-istart+1,:) = reshape(vect_1s{j}, [1, 9]);
end
input_vect = reshape(mean(input_seq), [3,3]);

%% Euclidean distance
for i = 1:size(output_seq,2)
    diff = 0;
    for j = 1:3
        for k = 1:3
%             a = output_seq(i).frame(j,k)
%             b = input_vect(j,k)
            diff = diff + (output_seq(i).frame(j,k) - input_vect(j,k))^2;
        end
    end
    output_seq(i).eucli_dist = sqrt(diff);
end

close all;
