%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% this function will create a motion vector between 2 frames passed as input
%  will divide it into mxm partitions
%  frameset : frames for which we need motion vector
%  m        : value of m to create mxm partitions of the image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [motvector]=get_motionVector(frameset,m)
%v=VideoReader(filename);
if(isempty(m))
    m=3;
end
[vidHeight,vidWidth]=size(frameset(:,:,1));
hpart=ceil(vidHeight/3);
wpart=ceil(vidWidth/3);
for gi=1:hpart:vidHeight
    for gj=1:wpart:vidWidth
        frame1=frameset(gi:gi+hpart,gj:gj+wpart,1);
        figure,imshow(frame1);
        frame2=frameset(gi:gi+hpart,gj:gj+wpart,2);
        figure,imshow(frame1);
        vect(gi,gj)=get_motionVect_perImg(frame1,frame2);% run for all the grids 
    end
end
%% convert motion vector into
motvector=reshape(vect,m*m,1);
end
