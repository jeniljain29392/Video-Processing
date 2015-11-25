function [reconst]=get_motionVect_celiu(frame1,frame2)

anchor=rgb2gray(frame1)
target=rgb2gray(frame2)

%% perform motion estimation using lucas-kanade

[u,v,~] = Coarse2FineTwoFrames(anchor,target);
reconst = thresholding(target, u, v);
end
