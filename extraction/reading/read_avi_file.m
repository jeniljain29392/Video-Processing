%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  this function is for reading avi file returns a 4-D matrix of interested
%  frames from the video whit specified iterval
%
%  filename : name of the file in single cotes e.g 'hey_ram.avi'
%  vstart   : specified start time for the video. in seconds
%  vend     : specified end time for the video. in seconds
%  interval : read consequtive frames at an interval
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [videomat] = read_avi_file(filename,vstart,vend,interval)
v = VideoReader(filename);

if(isempty(vstart))
    vstart = 1;
end
if(isempty(vend))
    vend = v.Duration;
end

k = 1;
startf = vstart .* v.FrameRate;
endf = vend .* v.FrameRate;
for i = startf:interval:endf-interval-1
    frames(:,:,:,k:k+1) = read(v,[i i+1]);
    k=k+2;
end
videomat = frames;
end
