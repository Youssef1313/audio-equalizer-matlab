function filters = iir_filters(order,fs,bands)
    filters = [];
    for i = 1:9
        band = bands(i,:) / (fs / 2);
        if band(2) >= 1
            return
        end
        if band(1) == 0
            [b, a] = butter(order,band(2));
            
        else
            [b, a] =  butter(order,band,'bandpass'); 
        end
        filter = Filter(b, a);
        filters = [filters filter];
    end
end