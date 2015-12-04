function playVideo(fileName, startTime, endTime)
    v = VideoReader(fileName);
    if(endTime > v.Duration)
        endTime = floor(v.Duration);
    end
    startFrame = startTime*v.FrameRate;
    endFrame = endTime*v.FrameRate;
    
    frames = read(v, [startFrame, endFrame]);
    [vidHeight,vidWidth,~, ~] = size(frames);
    mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
        'colormap',[]);

    for k = 1: size(frames,4)
        mov(k).cdata = frames(:,:,:,k);
    end

    hf = figure(1);
    set(hf,'position',[150 150 vidWidth vidHeight]);

    movie(hf,mov,1,v.FrameRate);
end 