function [videoVect] = get_videoVect(filename, vstart, vend, interval)

%% Read Video file
video = read_avi_file(filename, vstart, vend, interval);
[~,~,~,nFrames] = size(video);

%% Gets motion vector
for i=1:2:nFrames-1
    vect(ceil(i/2)) = {get_motionVect_celiu(video(:,:,:,1),video(:,:,:,2))};
%     vect(ceil(i/2)) = {get_motionVect_perImg(video(:,:,:,i),video(:,:,:,i+1))};
end

videoVect = vect;
end
