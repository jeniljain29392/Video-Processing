clc;
clear all;

%output_vects = get_videoVect('rgb-25-1.avi', [], [], 5);
%input_vects = get_videoVect('rgb-07-2.avi', 268, 278, 5);

load('vect_11_1.mat');
load('vect_25_1.mat');
output_vects = vect_11_1;
input_vects = vect_25_1;

%% Take average of n frames to get vector for one sec of the video
input_vect = vect_per_Nframes(input_vects, 3);
op_vect_per_sec = vect_per_Nframes(output_vects, 3);

istart = 269; iend = 278;
for j = istart:iend
   input_seq(j-istart+1,:) = reshape(input_vect{j}, [1, 9]);
end
input_vect = reshape(mean(input_seq), [3,3]);

%% kmeans clustering of the vectors of the frame
kmeans_IDX = Ndim_kmeans(op_vect_per_sec, 4);

%% Get sequences of consecutive simialar frames
sequences = splitVideo(op_vect_per_sec, kmeans_IDX);

%% Euclidean distance
for i = 1:size(sequences,2)
    sequences(i).eucli_dist = euclidean_distance(sequences(i).frame, input_vect);
    sequences(i).cosine_dist = cosine_distance(sequences(i).frame, input_vect);
end

%% scatter
for i = 1:size(sequences,2)
    x(i,:) = sequences(i).eucli_dist;
    y(i,:) = sequences(i).cosine_dist;
end
scatter(x,y);
pause;
close all;
