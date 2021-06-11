[file, path] = uigetfile("*.wav");
fullFileName = fullfile(path, file);

[data, fs] = audioread(fullFileName);

disp("File information:");
disp("Path: " + fullFileName);
disp("Data dimensions: " + mat2str(size(data)));
disp("Frequency: " + num2str(fs));


bands = get_bands(fs);
gains = zeros(1, 9);
for i = 1:length(bands)
    gains(i) = get_number("Enter gain for " + mat2str(bands(i,:) * fs) + " (between -20 dB and 20 dB): ", @(x) x >= -20 && x <= 20);
end


%filter_order = 100;
% band1 = fir1(filter_order, 170 / Fs);
% band2 = fir1(filter_order, [170 310] / Fs);
% band3 = fir1(filter_order, [310 600] / Fs);
% band4 = fir1(filter_order, [600 1000] / Fs);
% band5 = fir1(filter_order, [1000 3000] / Fs);
% band6 = fir1(filter_order, [3000 6000] / Fs);
% band7 = fir1(filter_order, [6000 12000] / Fs);
% band8 = fir1(filter_order, [12000 14000] / Fs);
% band9 = fir1(filter_order, [14000 16000] / Fs);


%test = apply_filters(X, { band1, band2, band3, band4, band5, band6, band7, band8 });
%audiowrite('out.wav', test, Fs);

function f = apply_filters(signal, band_filters)
    output = signal .* 0;
    for i = 1:length(band_filters)
        output = output + filter(cell2mat(band_filters(i)), 1, signal);
    end
    f = output;
end
