[file, path] = uigetfile('*.wav');
fullFileName = fullfile(path, file);

[data, original_fs] = audioread(fullFileName);

disp('File information:');
disp(['Path: ' fullFileName]);
disp(['Data dimensions: ' mat2str(size(data))]);
disp(['Frequency: ' num2str(original_fs)]);

bands = get_bands();

fs = original_fs;
if bands(end, end) >= fs / 2
   margin = 11;
   fs = 2 * (bands(end, end) + margin);
   data = resample(data, fs, original_fs); 
end

gains = zeros(1, length(bands));
for i = 1:length(bands)
    gains(i) = get_number(['Enter gain for ' mat2str(bands(i,:)) 'Hz (between -20 dB and 20 dB): '], @(x) x >= -20 && x <= 20);
end

filter_type = get_string('Enter filter type ("fir" or "iir"):', @(x) strcmp('fir', x) || strcmp('iir', x));

output_fs = get_number('Enter a valid output sample rate: ', @(x) x > 340);

<<<<<<< HEAD
if strcmp('fir', filter_type)
=======
if strcmp('fir', output_fs)
>>>>>>> 4ded03d (Minor fixes)
   fir_order = 40;
   filters = fir_filters(fir_order, fs, bands);
else
   iir_order = 4;
   filters = iir_filters(iir_order, fs, bands);
end

acc_filtered = data .* 0;
for i = 1:length(filters)
    x = fvtool(filters(i).Numerator, filters(i).Denominator);
    x.NormalizedFrequency = 'off';
    x.fs = fs;
    x.Name = [mat2str(bands(i,:)) 'Hz'];
    filtered = filter(filters(i).Numerator, filters(i).Denominator, data);
    plot_time_frequency_domain(filtered, output_fs);
    acc_filtered = filtered * (10 ^ (gains(i) / 20)) + acc_filtered;
end

acc_filtered = resample(acc_filtered, output_fs, fs); %resample to the output fs
plot_time_frequency_domain(data, original_fs, acc_filtered, output_fs);

[file, path] = uiputfile('*.wav');
fullFileName = fullfile(path, file);

audiowrite(fullFileName, acc_filtered, output_fs);
