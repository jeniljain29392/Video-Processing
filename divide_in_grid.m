%% divides images int mxm images and removes w rows and columns from parameter image
function [vect]=divide_in_grid(image,m,w)
temp=image(w+1:end-w,w+1:end-w);
[p,n] = size(temp);
pheight = floor(p/m);
pwidth = floor(n/m);
for i=1:m
    for j=1:m
        vect(i,j)=sum(sum(temp((pheight)*(i-1)+1:pheight*i,(pwidth)*(j-1) + 1:j*pwidth)));
    end
end
