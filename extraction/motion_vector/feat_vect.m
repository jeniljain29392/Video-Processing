clc;
clear all;
path = pwd;
addpath(genpath(path));
files = dir(strcat(path, '\dataset\motion_vectors\', '*.mat'));

for file = files'
    load(strcat(path, '\dataset\motion_vectors\', file.name));
    outpt_grid = divide_in_grid(vectmat, 80);
    save(strcat(path, '\dataset\feature_vectors\', 'f_vect-', file.name(8:11), '.mat'), 'outpt_grid');
end