function [vect]=get_motionVect_perImg(frame1,frame2,partition)
[m,n,~]=size(frame1);
% run algorithm to get optical flow
ww= 40;
w=round(ww/2);
anchort=im2double(padarray(rgb2gray(frame1),[w w],0));
targett=im2double(padarray(rgb2gray(frame2),[w w],0));
anchor=anchort;%imresize(anchort,0.5);
target=targett;%imresize(targett,0.5);
%% perform motion estimation using lucas-kanade
u = zeros(size(anchor));
v = zeros(size(anchor));
I_x=conv2(anchor,[-1 1;-1 1],'valid');      % get partial derivative in x direction
I_y=conv2(anchor,[-1 -1;1 1],'valid');      % get partial derivative in y direction
I_t=conv2(anchor,ones(2),'valid') + conv2(target,-ones(2),'valid'); % get partial derivative in t direction
for j=w+1:2:size(I_x,1)-w
    for k=w+1:2:size(I_x,2)-w
        Ix = I_x(j-w:j+w, k-w:k+w);
        Iy = I_y(j-w:j+w, k-w:k+w);
        It = I_t(j-w:j+w, k-w:k+w);
        
        Ix = Ix(:);
        Iy = Iy(:);
        b = -It(:); % get b here
        
        A = [Ix Iy]; % get A here
        nu = pinv(A)*b; % get velocity here
        
        u(j,k)=nu(1); % velocity of motion in x direction
        v(j,k)=nu(2); % velocity of motion in y direction
    end;
end;
%figure,imshow(anchor);
%figure,imshow(target);

%% interpolated image

% K-means - where number of cluster chosen as k = 2, as the motion is only
% at the center(Man walking).
% reconst1 = k_mean(targett, u, v, 2);
% figure,imshow(reconst1,[]);title('K-means');

% Thresholding - using histogram of motion vectors we find out the
%distribution and set a threshold
reconst2 = thresholding(targett, u, v);
figure,imshow(reconst2,[]); title('Thresholding');
[vect] = divide_in_grid(reconst2, 3, w);
end
