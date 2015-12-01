%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  divides images int mxm images and removes w rows and columns from
%  parameter image
%  frame1 : Anchor frame
%  frame2 : Target Frame
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
function [vect] = divide_in_grid(image,w)
nframes = size(image, 2);
[n,m] = size(image{1});
ht = floor(n/w);      %height after dividing image into mxm grid
wt = floor(m/w);      %weight after dividing image into mxm grid
for k=1:nframes
    for i=1:w
        for j=1:w
            vect{k}(i,j) = sum(sum(image{k}((ht)*(i-1)+1:i*ht,...
                (wt)*(j-1)+1:j*wt)));
        end
    end
end
