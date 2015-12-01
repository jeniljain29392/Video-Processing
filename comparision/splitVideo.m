%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  this function Split a given video into clips of similar frames having
%  consistent motion in similar regions.
%
%  video_vect : motion vector of the video from the dataset (k * (W x W))
%  kmeans_IDX : K-mean Clustering index array of a video (1 x m)
%  seq_len    : minimum length of the clip; e.g. 10 for 5 sec clip
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [clips] = splitVideo(video_vect, kmeans_IDX, seq_len)

[~,len] = size(kmeans_IDX);
interval = [];
count = 0;

for i = 1: len-1
    % increase count if cluster ID is same
    if(kmeans_IDX(i)==kmeans_IDX(i+1))
        count = count + 1;
    
    % Count have to br more than minimum clip size to represent a 
    % particular activity   
    elseif(count>=seq_len)
        interval(size(interval,2)+1) = i - count;
        interval(size(interval,2)+1) = i ;
        count = 0;
    else
        count = 0;
    end
end

% save the interval of the clip
interval(1) = 1;
interval(1, size(interval,2)+1) = len;

% since a clip contains similar motion vector, get an average vector to
% represent the clip and save in into a struct along with time stamps
k = 1;
[row, col] = size(video_vect{1});
clips = struct('frame', [],'start', [], 'end', []);

for i = 1:size(interval,2)-1
    fstart = interval(i);
    fend = interval(i+1);
    
    % consider clip which is more than 5 seconds
    if (fend - fstart)>= seq_len/2
        for j = fstart:fend
            avg_seq(j,:) = reshape(video_vect{j}, [1, row*col]);
        end
        clips(k).frame = reshape(mean(avg_seq(fstart:fend, :)),[row, col]);
        clips(k).start = fstart;
        clips(k).end = fend;
        k = k + 1;
        clear avg_seq;
    end
end
end
