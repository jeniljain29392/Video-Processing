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
hpart=floor(vidHeight/m);
wpart=floor(vidWidth/m);
for gi=1:m
    for gj=1:m
        frame1=frameset((hpart)*(gi-1)+1:gi*(hpart),(gj-1)*(wpart)+1:gj*(wpart),:,1);
        figure,imshow(frame1);
        frame2=frameset((hpart)*(gi-1)+1:gi*(hpart),(gj-1)*(wpart)+1:gj*(wpart),:,2);
        figure,imshow(frame2);
        vect(k)={get_motionVect_perImg(frame1,frame2,3)};% run for all the grids 
        k=k+1;
    end
end
%% convert motion vector into
motvector=vect;
end
