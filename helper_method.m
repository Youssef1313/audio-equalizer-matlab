band =[0 170;170 310;310 600;600 1000;1000 3000;3000 6000;6000 12000;12000 14000;14000 16000];
function filters = iir_filters(order,fs)
filters = []
band_norm = (band * 2)/(fs);
    for i = 1:9
        if band_norm(i+1) >= 1
            return
        end
        if band(i) == 0
            filters(i,:) = butter(5,band_norm(2)); 
        else
            filter(i,:) =  butter(3,band_norm(i,:),'bandpass'); 
        end
    end
end

