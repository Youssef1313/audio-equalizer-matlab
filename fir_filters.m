function filters = fir_filters(order, fs, bands)
    filters = [];
    for i = 1:length(bands)
       band = bands(i,:) / (fs / 2);
       if band(2) >= 1
           return
       elseif band(1) == 0
           b = fir1(order, band(2));
       else
           b = fir1(order, band);
       end
       filter = Filter(b, 1);
       filters = [filters filter];
    end
end
