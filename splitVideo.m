function [splitOut] = splitVideo(a)
    [~,len] = size(a);
    interval = [0];
    count = 0;
    for i = 1: len-1
        if(a(i)==a(i+1))
            count = count +1;
        elseif(count>=5)
            interval(size(interval,2)+1) = i - count;
            interval(size(interval,2)+1) = i ;
            count = 0;
        else
            count = 0;
        end
    end
    interval(1) = 1;
    interval(1, size(interval,2)+1) = len;
    [splitOut] = interval;
end
