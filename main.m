%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This function retrive similar videos from the dataset based on
%   euclidean and cosine distance and assign a rank to it using a Min Heap
%
%   filename : Name of the input video file; e.g. 'rgb-17-2.avi'
%   istrt    : Start time of the video clip in sec; e.g. 230 sec
%   istop    : Stop time of the video clip in sec;  e.g. 240 sec
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function main(filename, istrt, istop)
clc;

% Tuning parameter
W = 40;                 % grid size
min_duration = 5;       % minimum size of the clip
no_of_cluster = 4;      % number of clusters
clip_resolution = 1;    % half sec or a sec of video

% Reading all mat files
path = pwd;
addpath(genpath(path));
files = dir(strcat(path, '\dataset\motion_vectors\', '*.mat'));

% Get input clip and dataset
% %Get input vectors directly from the video file at an interval of 5
% input_vects = get_videoVect(filename, istrt, istop, 5);

% Get input vectors from the saved vector mat files
input_clip = get_inputClip(filename, istrt, istop);
outpt_clips = struct('name', {}, 'clips', {});

% Allocating Heaps based on euclidean and cosine distane
nVideos = size(files, 1);
clips_per_vid = 3;
Eucli_Ranking = MinHeap(nVideos * clips_per_vid);
Cosin_Ranking = MinHeap(nVideos * clips_per_vid);
Ranking = struct('Euclidean', {}, 'Cosine', {});

% Retrive Clips from all the videos of the dataset
j = 1;
for file = files'
    tic
    % Do not retrieve clips from the same video
    if ~strcmp(file.name, input_clip.name)
        
        clip_name = strcat('clips-', file.name(8:11), '.mat');
        outpt_clips(j).name = strcat('rgb-',file.name(8:11), '.avi');
        outpt_clips(j).clips = struct('start', {}, 'end', {}, 'eucli_dist'...
            ,{}, 'cosine_dist', {});
        
        % Process the videos in the dataset only once
        cd(strcat(path, '\clips\'));
        if ~exist(clip_name)
            
            cd(path);
            load(strcat(path, '\dataset\motion_vectors\', file.name));
            
            % Divide vectors into WxW grid. A grid contains the average
            % value of all the pixels from the motion segmented frame.
            outpt_grid = divide_in_grid(vectmat, W);
            
            % Take average of n frames to get vector for half sec of the video
            op_vect_half_sec = vect_per_Nframes(outpt_grid, 6*clip_resolution);
            
            %%kmeans clustering of the frames.Four clusters are
            % 1. cutting  : motion is along the center of the screen
            % 2. mixing   : motion is along the right corner of the screen
            % 3. dressing : motion is along bottom of the screen as well as
            %               along center
            % 4. No motion
            kmeans_IDX = Ndim_kmeans(op_vect_half_sec, no_of_cluster);
            
            % Get sequences of consecutive simialar frames having same
            % motion regions. And minimum size of the clip is 5 sec.
            clips = splitVideo(op_vect_half_sec, kmeans_IDX, min_duration *...
                clip_resolution);
            
            % save clips information of a particular video
            cd(strcat(path, '\clips\'));
            save(clip_name, 'clips');
            cd(path);
            
        else
            % Load the processed data
            load(clip_name);
            cd(path);
        end
        
        % Divide vectors into WxW grid
        input_grid = divide_in_grid(input_clip.vect, W);
        
        % Get a vector for the input clip. Since input clip represent an
        % action which will have consistent motion vector along a
        % particular region, we can use a single vector to represent the
        % whole input clip.
        input_vect = vect_per_Nframes(input_grid, []);
        
        % Euclidean and Cosine distance Heap
        nClips = max(3, size(clips,2));
        eucli_heap = MinHeap(nClips);
        cosin_heap = MinHeap(nClips);
        heap_entry = struct();
        heap_entry.name = file.name;
        
        for i = 1:size(clips,2)
            
            % Get the start time of the video clip
            outpt_clips(j).clips(i).start = clips(i).start;
            heap_entry.start = clips(i).start;
            
            % Get the Stop time of the video clip
            outpt_clips(j).clips(i).end = clips(i).end;
            heap_entry.stop = clips(i).end;
            
            % Get the euclidean distance of the input and the output vector
            % and add the clip into the heap
            outpt_clips(j).clips(i).eucli_dist = ...
                euclidean_distance(clips(i).frame, input_vect);
            heap_entry.dist = outpt_clips(j).clips(i).eucli_dist;
            eucli_heap.InsertKey(heap_entry);
            
            % Get the cosine distance of the input and the output vector
            % and add the clip into the heap
            outpt_clips(j).clips(i).cosine_dist = ...
                cosine_distance(clips(i).frame, input_vect);
            heap_entry.dist = outpt_clips(j).clips(i).cosine_dist;
            cosin_heap.InsertKey(heap_entry);
        end
        
        % Save the top 3 similar clips from each video into a Main Heap. 
        for i=1:min(clips_per_vid, size(clips,2))
            Eucli_Ranking.InsertKey( eucli_heap.ExtractMin() );
            Cosin_Ranking.InsertKey( cosin_heap.ExtractMin() );
        end
        j = j + 1;
    end
    toc
end

% Save all the processed data into a main output file
Ranking(1).Euclidean = Eucli_Ranking;
Ranking(1).Cosine    = Cosin_Ranking;
save(strcat(path,'\retrieval\','Ranking.mat'), 'Ranking');
save(strcat(path,'\retrieval\','output.mat'), 'outpt_clips');
output;
end
