function main(filename, istrt, istop)
tic
clc;
% clear all;

%% Get input clip and dataset
input_clip = get_inputClip(filename, istrt, istop);
outpt_clips = struct('name', {}, 'clips', {});

path = pwd;
files = dir(strcat(path, '\dataset\', '*.mat'));
clips_mat = dir(strcat(path, '\clips\', '*.mat'));

j = 1;
for file = files'
    tic
    if ~strcmp(file.name, input_clip.name)
        
        clip_name = strcat('clips-', file.name(8:11), '.mat');
        cd(strcat(path, '\clips\'));
        if ~exist(clip_name)
            
            cd(path);
            load(strcat(path, '\dataset\', file.name));

            %% Divide vectors into WxW grid
            outpt_grid = divide_in_grid(vectmat, 80);

            %% Take average of n frames to get vector for one sec of the video
            op_vect_half_sec = vect_per_Nframes(outpt_grid, 3);

            %% kmeans clustering of the vectors of the frame
            kmeans_IDX = Ndim_kmeans(op_vect_half_sec, 4);

            %% Get sequences of consecutive simialar frames
            clips = splitVideo(op_vect_half_sec, kmeans_IDX, 10);

            %% save clips information of a particular video
            cd(strcat(path, '\clips\'));
            save(clip_name, 'clips');
            cd(path);
            
        else
            load(clip_name);
            cd(path);
        end
        
        %% Divide vectors into WxW grid
        input_grid = divide_in_grid(input_clip.vect, 80);
            
        %% Get a vector for the input clip
        input_vect = vect_per_Nframes(input_grid, []);
        
        outpt_clips(j).name = strcat('rgb-',file.name(8:11), '.avi');
        outpt_clips(j).clips = struct('start', {}, 'end', {}, 'eucli_dist'...
                                    ,{}, 'cosine_dist', {});
                                
        %% Euclidean and Cosine distance
        for i = 1:size(clips,2)
            
            outpt_clips(j).clips(i).start = clips(i).start;
            
            outpt_clips(j).clips(i).end = clips(i).end;
            
            outpt_clips(j).clips(i).eucli_dist = ...
                euclidean_distance(clips(i).frame, input_vect);
            
            outpt_clips(j).clips(i).cosine_dist = ...
                cosine_distance(clips(i).frame, input_vect);
        end
        j = j + 1;
    end
    toc
end
save('output.mat', 'outpt_clips');
toc
end
