%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  this function gets motion vectors directly from the video file using 
%  either Lukas-Kanade or Ce Lie's motion estimation

%  filename : Name of the input video file; e.g. 'rgb-17-2.avi'
%  istrt    : Start time of the video clip in sec; e.g. 230 sec
%  istop    : Stop time of the video clip in sec;  e.g. 240 sec
%  interval : read frames at an interval
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [vectmat] = get_videoVect(filename, istrt, istop, interval)

% Read Video file
videomat = read_avi_file(filename, istrt, istop, interval);
[~,~,~,nFrames] = size(videomat);

% Gets motion vector
for i=1:2:nFrames
    vectmat(ceil(i/2)) = {get_motionVect_celiu(videomat(:,:,:,i),videomat(:,:,:,i+1))};
end
end
