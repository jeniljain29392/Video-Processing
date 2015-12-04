%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This function divides the frame into a WxW grid.
%
%  motion_vect : motion vector of input and output clips (nframes*(n x m))
%  w           : Grid size, e.g. for a 480x640 80 is a common multiple
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
function [vect] = divide_in_grid(motion_vect,w)

nframes = size(motion_vect, 2);
[n,m] = size(motion_vect{1});
ht = floor(n/w);      %height of a WxW grid
wt = floor(m/w);      %width of a WxW grid

for k=1:nframes
    for i=1:w
        for j=1:w
            vect{k}(i,j) = sum(sum(motion_vect{k}((ht)*(i-1)+1:i*ht,...
                (wt)*(j-1)+1:j*wt)));
        end
    end
end
