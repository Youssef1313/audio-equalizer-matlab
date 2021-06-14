function filters = iir_filters(order,fs,bands)
    filters = [];
    for i = 1:length(bands)
        band = bands(i,:) / (fs / 2);
        if band(1) == 0
            [b, a] = butter(order,band(2));
            
        else
            [b, a] =  butter(order,band,'bandpass'); 
        end
        filters = [filters Filter(b, a)];
    end
end