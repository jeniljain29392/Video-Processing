%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  this function does motion estimation using Ce Liu's Optical Flow 
%  implementation and motion segmentation using thresholding.
%  frame1 : Anchor frame
%  frame2 : Target Frame
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [reconst]=get_motionVect_celiu(frame1,frame2)

anchor=rgb2gray(frame1);
target=rgb2gray(frame2);

%% perform motion estimation
[u,v,~] = Coarse2FineTwoFrames(anchor,target);

%% perform segmentation using thresholding
reconst = thresholding(target, u, v);
end