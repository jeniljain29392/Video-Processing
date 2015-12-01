function reconst = k_mean(anchor, u, v, k)
    [mlim,nlim]=size(anchor);
    reconst = zeros(mlim,nlim);
    
    tuv=((abs(u)+abs(v))/2); %% medfilt2
    [nrows,ncols]=size(tuv);
    ttuv=reshape(tuv,nrows*ncols,1);
    idx=kmeans(ttuv,k);
    reconst=reshape(idx,[nrows,ncols]);
end
