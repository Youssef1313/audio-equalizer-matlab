function plot_requirements(filter, fs, name)
    x = fvtool(filter.Numerator, filter.Denominator);
    set_common_properties(x, fs);
    x.Analysis = 'freq';
    x.Name = ['Magnitude response (dB) and phase response of filter: ' name];

    x = fvtool(filter.Numerator, filter.Denominator);
    set_common_properties(x, fs);
    x.Analysis = 'impulse';
    x.Name = ['Impulse response of filter: ' name];

    x = fvtool(filter.Numerator, filter.Denominator);
    set_common_properties(x, fs);
    x.Analysis = 'step';
    x.Name = ['Step response of filter: ' name];

    x = fvtool(filter.Numerator, filter.Denominator);
    set_common_properties(x, fs);
    x.Analysis = 'polezero';
    x.Name = ['Pole-zero plot of filter: ' name];
end

function set_common_properties(x, fs)
    x.NormalizedFrequency = 'off';
    x.fs = fs;
    x.WindowStyle = 'normal';
    x.NumberTitle = 'off';
end