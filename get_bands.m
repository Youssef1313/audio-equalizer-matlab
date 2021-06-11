function bands = get_bands(fs)
    fs = fs / 2;
    if fs > 16000
        bands = [0 170;
                 170 310;
                 310 600;
                 600 1000;
                 1000 3000;
                 3000 6000;
                 6000 12000;
                 12000 14000;
                 14000 16000];
    elseif fs > 14000
        bands = [0 170;
                 170 310;
                 310 600;
                 600 1000;
                 1000 3000;
                 3000 6000;
                 6000 12000;
                 12000 14000];
    elseif fs > 12000
        bands = [0 170;
                 170 310;
                 310 600;
                 600 1000;
                 1000 3000;
                 3000 6000;
                 6000 12000];
    elseif fs > 6000
        bands = [0 170;
                 170 310;
                 310 600;
                 600 1000;
                 1000 3000;
                 3000 6000];
    elseif fs > 3000
        bands = [0 170;
                 170 310;
                 310 600;
                 600 1000;
                 1000 3000];
    elseif fs > 1000
        bands = [0 170;
                 170 310;
                 310 600;
                 600 1000];
    elseif fs > 600
        bands = [0 170;
                 170 310;
                 310 600];
    elseif fs > 310
        bands = [0 170;
                 170 310];
    elseif fs > 170
        bands = [0 170];
    else
        throw(MException("The given frequency is too low."));
    end
    bands = bands / fs;
end
