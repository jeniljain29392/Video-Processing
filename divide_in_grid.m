%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  divides images int mxm images 
%  image : Frame to be divided into grid
%  w = window size of the grid
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [vect] = divide_in_grid(image,w)
[n,m] = size(image);
ht_w = floor(n/w);      %height after dividing image into mxm grid
wt_w = floor(m/w);      %weight after dividing image into mxm grid
for i=1:w
    for j=1:w
        vect(i,j) = sum(sum(image((ht_w)*(i-1)+1:i*ht_w,...
                                  (wt_w)*(j-1)+1:j*wt_w)));
    end
end
