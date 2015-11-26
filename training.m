%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  this file 
%   - read all the Video files in the dataset
%   - perform motion estimation and segmentation
%   - save vectors into the mat file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
files = dir('*.avi');
motion_vector_arr = struct();
motion_vector_arr.name = '';

j = 1;
for file = files'
    
    % Perform Motion estimation
    videomat = read_avi_file(file.name, 1, 2, 5);
    [~,~,~,nFrames] = size(videomat);
    vectmat = repmat(cell(1), 1, nFrames);
    
    % Perform motion segmentation
    for i=1:2:nFrames-1
        vectmat(ceil(i/2)) = {get_motionVect_celiu(videomat(:,:,:,i)...
        ,videomat(:,:,:,i+1))};
    end
    
    motion_vector_arr(j).name = file.name;
    motion_vector_arr(j).motionVectors = vectmat;
    j=j+1;
end

save motion_vector_arr.mat motion_vector_arr;
close all;
