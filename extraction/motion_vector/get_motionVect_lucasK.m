%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  this function does motion estimation using Lukas-Kanade Optical Flow 
%  implementation and motion segmentation using thresholding.
%  frame1 : Anchor frame
%  frame2 : Target Frame
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [reconst]=get_motionVect_lucasK(frame1,frame2)

%% run algorithm to get optical flow
ww= 40;
w=round(ww/2);
anchort=im2double(padarray(rgb2gray(frame1),[w w],0));
targett=im2double(padarray(rgb2gray(frame2),[w w],0));
anchor=anchort;
target=targett;

%% perform motion estimation using lucas-kanade
u = zeros(size(anchor));
v = zeros(size(anchor));

% get partial derivative in x direction
I_x=conv2(anchor,[-1 1;-1 1],'valid');      

% get partial derivative in y direction
I_y=conv2(anchor,[-1 -1;1 1],'valid');      

% get partial derivative in t direction
I_t=conv2(anchor,ones(2),'valid') + conv2(target,-ones(2),'valid'); 

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

% Thresholding - using histogram of motion vectors we find out the
% distribution and set a threshold
reconst = thresholding(targett, u, v);

end
