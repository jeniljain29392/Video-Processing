%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% this function is for reading avi file returns a 4-D matrix of interested
%  frames from the video whit specified iterval
%  filename : name of the file in single cotes e.g 'hey_ram.avi'
%  vstart   : specified start time for the video. in seconds
%  vend     : specified end time for the video. in seconds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [videomat]=read_avi_file(filename,vstart,vend,interval)
v=VideoReader(filename);

vidHeight=v.Height;
vidWidth=v.Width;
if(isempty(vstart))
    vstart=1;
end
if(isempty(vend))
    vend=v.Duration.*v.FrameRate;
end
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);
k=1;
startf=vstart.*v.FrameRate;
endf=vend.*v.FrameRate;
for i=startf:interval:endf
frames(:,:,:,k)=read(v,i);
     k=k+1;
 end
videomat=frames;
[~,~,~,n]=size(videomat);
% for i=1:10
%     figure,imshow(videomat(:,:,:,i));
% end
end
