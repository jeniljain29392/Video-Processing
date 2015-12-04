%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This file extract feature vector from thr motion vector mat files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
path = pwd;
addpath(genpath(path));
motion_vect_path = uigetdir('C:\');
files = dir(strcat(motion_vect_path, '\*.mat'));

for file = files'
    load(strcat(motion_vect_path, '\', file.name));
    f_vect = divide_in_grid(vectmat, 40);
    save(strcat(path, '\dataset\', 'f_vect-', file.name(8:11), '.mat'), 'f_vect');
end
