[file, path] = uigetfile('*.wav');
fullFileName = fullfile(path, file);

[data, fs] = audioread(fullFileName);

disp('File information:');
disp(strcat('Path: ',fullFileName));
disp(strcat('Data dimensions: ', mat2str(size(data))));
disp(strcat('Frequency: ' , num2str(fs)));

plot_time_frequency_domain(data, fs);


bands = get_bands();
gains = zeros(1, length(bands));
for i = 1:length(bands)
    gains(i) = get_number(['Enter gain for ' mat2str(bands(i,:)) 'Hz (between -20 dB and 20 dB): '], @(x) x >= -20 && x <= 20);
end

filter_type = get_string('Enter filter type ("fir" or "iir"):', @(x) strcmp('fir',x) || strcmp('iir',x));

% The lowpass filter has cutoff freq = 170.
% Since the normalized frequency = cutoff / (fs/2), fs must
% be greater than 340.
output_fs = get_number('Enter a valid output sample rate: ', @(x) x > 340);

if strcmp('fir',output_fs)
   fir_order = 40;
   filters = fir_filters(fir_order, output_fs, bands);
else
   iir_order = 4;
   filters = iir_filters(iir_order, output_fs, bands);
end

filtered = data .* 0;
for i = 1:length(filters)
    x = fvtool(filters(i).Numerator, filters(i).Denominator);
    x.NormalizedFrequency = 'off';
    x.fs = output_fs;
    x.Name = [mat2str(bands(i,:)) 'Hz'];
    filtered = filtered + filter(10 ^ (gains(i) / 20) * filters(i).Numerator, filters(i).Denominator, data);
end

[file, path] = uiputfile('*.wav');
fullFileName = fullfile(path, file);

% Normalize the signal to ±1 to avoid data clipping when writing.
audiowrite(fullFileName, filtered / max(abs(filtered)), output_fs);
