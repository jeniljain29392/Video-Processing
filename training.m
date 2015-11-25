clc;
clear all;
files = dir('*.avi');
motion_vector_arr = struct();
motion_vector_arr.name = '';
motion_vector.motionVectors = [];
j = 1;
for file = files'
    videomat = read_avi_file(file.name, [], [], 5);
    [~,~,~,nFrames] = size(videomat);
    vectmat = repmat(cell(1), 1, nFrames);
    
    for i=1:2:2
        vectmat(ceil(i/2)) = {get_motionVect_celiu(videomat(:,:,:,i)...
        ,videomat(:,:,:,i+1))};
    end
    
    motion_vector_arr(j).name = file.name;
    motion_vector_arr(j).motionVectors = vectmat;
    j=j+1;
end
%get_motionVect_perImg(videomat(:,:,:,1), videomat(:,:,:,2));
save motion_vector_arr.mat motion_vector_arr;
close all;
