function [vect]=get_motionVect_perImg(frame1,frame2)
    [m,n]=size(frame1);
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
        figure,imshow(anchor);
        figure,imshow(target);
% downsize u and v
u_deci = u(1:5:end, 1:5:end);
v_deci = v(1:5:end, 1:5:end);
% get coordinate for u and v in the original frame
[m, n] = size(anchort);
[X,Y] = meshgrid(1:n, 1:m);
X_deci = X(1:5:end, 1:5:end);
Y_deci = Y(1:5:end, 1:5:end);

%% Plot optical flow field
 figure();
 imshow(targett);
 hold on;
% % draw the velocity vectors
 quiver(X_deci, Y_deci, u_deci,v_deci, 'y');
 vect=[u_deci,v_deci];
%% interpolated image
end
