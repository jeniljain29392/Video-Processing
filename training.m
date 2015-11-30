%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  this file 
%   - read all the Video files in the dataset
%   - perform motion estimation and segmentation
%   - save vectors into the mat file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
files = dir('*.avi');

j = 1;
for file = files'
    
    % Perform Motion estimation
    videomat = read_avi_file(file.name, [], [], 5);
    %load(' video_18_02.mat');
    [~,~,~,nFrames] = size(videomat);
    vectmat = repmat(cell(1), 1, nFrames);
    
    % Perform motion segmentation
    for i=1:2:nFrames-1
        i
        vectmat(ceil(i/2)) = {get_motionVect_celiu(videomat(:,:,:,i)...
        ,videomat(:,:,:,i+1))};
    end

    j=j+1;
end

save -v7.3 vectmat_17_02.mat vectmat;
close all;
