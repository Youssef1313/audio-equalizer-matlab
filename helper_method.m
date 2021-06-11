
function filters = iir_filters(order,fs,bands)
    filters = [];
    band_norm = (bands * 2) / (fs) ;
    for i = 1:9
        if band_norm(i+1) >= 1
            return
        end
        if band(i) == 0
            [b a] = butter(5,band_norm(2));
            
        else
            [b a] =  butter(3,band_norm(i,:),'bandpass'); 
        end
        filter = Filters(b, a)
        filters = [filters filter]
    end
end

function 