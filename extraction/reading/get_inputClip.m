%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This function retrieve input clip from the mat file
%
%   filename : Name of the input video file; e.g. 'rgb-17-2.avi'
%   istrt    : Start time of the video clip in sec; e.g. 230 sec
%   istop    : Stop time of the video clip in sec;  e.g. 240 sec
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [input_clip] = get_inputClip(filename, istrt, istop)

input_clip = struct('name',{}, 'vect', {});

%%get file name of vectmat file
file_no = filename(5:8);
mat_file = strcat('vector-', file_no, '.mat');
input_clip(1).name = mat_file;

%%Load vectmat file of corresponding filename
path = pwd;
mat_file = strcat(path, '\dataset\', mat_file);
load(mat_file);

%%Each second of a video have 6 motion vectors, since frames are read at an
%%interval of 5.
strt_frame = ceil(istrt * 6);
stop_frame = ceil(istop * 6);
for j = strt_frame:stop_frame
    input_clip(1).vect{j-strt_frame+1} = vectmat{j};
end
end