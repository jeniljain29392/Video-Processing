%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% this function will create a motion vector between 2 frames passed as input
%  will divide it into mxm partitions
%  frameset : frames for which we need motion vector
%  m        : value of m to create mxm partitions of the image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [motvector]=get_motionVector(frameset,m)
v=VideoReader(filename);
if(isempty(m))
    m=3;
end
[vidHeight,vidWidth]=size(frameset(:,:,1));
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
