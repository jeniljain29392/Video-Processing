function reconst = thresholding(anchor, u, v)
    [mlim,nlim]=size(anchor);
    reconst = zeros(mlim,nlim);
    tuv=((abs(u)+abs(v))/2); %% medfilt2
    [nrows,ncols]=size(tuv);
    ttuv=reshape(tuv,nrows*ncols,1);
    [~,centers]= hist(ttuv);
    
    %by changing the center number, we can decide the area of the segment
    %larger the center, more the area and hence more distortion around
    %center.
    
    for j=1:mlim
        for k=1:nlim
            if(tuv(j,k)>centers(3))
                reconst(j,k)=1;
            else
                reconst(j,k)=0;            
            end
        end
    end
end
