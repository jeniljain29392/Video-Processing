%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This function averages N vectors into one vector for an input clip,
%  while for output it averages 3 vectors to represent a vector for half
%  sec of the video.
%
%  vect : motion vector of input and output clips (nframes*(n x m))
%  n    : Grid size, e.g. for a 480x640 80 is a common multiple
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [vect_per_Nframes] = vect_per_Nframes(vect, n)

[~,nFrames] = size(vect);
[row, col] = size(vect{1});

% averaging all vectors of the input clip to get a single vector
if(isempty(n))
    for i = 1:nFrames
        reshaped_vect(i,:) = reshape(vect{i}, [1, row*col]);
    end
    vect_per_Nframes = reshape(mean(reshaped_vect), [row, col]);

% averaging 3 vectors to get a vector for half second of the clip
else
    for i = 1:n:nFrames-n
        for j = 0:n-1
            reshaped_vect(j+1,:) = reshape(vect{i+j}, [1, row*col]);
        end
        vect_per_Nframes{ceil(i/n)} = reshape(mean(reshaped_vect), [row, col]);
    end
end
end
