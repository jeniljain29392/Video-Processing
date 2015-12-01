function [input_clip] = get_inputClip(filename, istrt, istop)

input_clip = struct('name',{}, 'vect', {});

%% get file name of vectmat file
file_no = filename(5:8);
mat_file = strcat('vector-', file_no, '.mat');
input_clip(1).name = mat_file;

%% Load vectmat file of corresponding filename
path = pwd;
mat_file = strcat(path, '\dataset\', mat_file);
load(mat_file);

strt_frame = istrt * 6;
stop_frame = istop * 6;
for j = strt_frame:stop_frame
    input_clip(1).vect{j-strt_frame+1} = vectmat{j};
end
