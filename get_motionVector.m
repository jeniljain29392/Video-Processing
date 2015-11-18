%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% this function will create a motion vector between 2 frames passed as input
%  will divide it into mxm partitions
%  frameset : frames for which we need motion vector
%  m        : value of m to create mxm partitions of the image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [motvector]=get_motionVector(frameset,m)
%v=VideoReader(filename);
k=1;
if(isempty(m))
    m=3;
end
[vidHeight,vidWidth]=size(frameset(:,:,1));
hpart=floor(vidHeight/3);
wpart=floor(vidWidth/3);
for gi=1:hpart:vidHeight-hpart+1
    for gj=1:wpart:vidWidth-wpart+1
        gi+hpart
        gj+wpart
        frame1=frameset(gi:gi+hpart-1,gj:gj+wpart-1,:,1);
 %       figure,imshow(frame1);
        frame2=frameset(gi:gi+hpart-1,gj:gj+wpart-1,:,2);
%        figure,imshow(frame1);
        vect(k)={get_motionVect_perImg(frame1,frame2)};% run for all the grids 
        k=k+1;
    end
end
%% convert motion vector into
motvector=vect;
end
