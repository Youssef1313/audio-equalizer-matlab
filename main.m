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

order = 150;
if strcmp('fir', filter_type)
   order = 150;
   filters = fir_filters(order, fs, bands);
else
   order = 4;
   filters = iir_filters(order, fs, bands);
end

acc_filtered = data .* 0;

freq_range_plt = [' 0-170  HZ'; '170-310 HZ'; '310-600 HZ'; '0.6-1  KHZ'; '1-3    KHZ'; '3-6    KHZ'; '6-12   KHZ'; '12-14  KHZ'; '14-16  KHZ'];
for i = 1:length(filters)    
    x = fvtool(filters(i).Numerator, filters(i).Denominator);
    x.NormalizedFrequency = 'off';
    x.fs = fs;
    x.Name = [mat2str(bands(i,:)) 'Hz'];
    [z, p, k] = tf2zpk(filters(i).Numerator, filters(i).Denominator);
    fprintf('The gain of %s filter : %s  is %f , Order is %d \n',filter_type, freq_range_plt(i,:), k, order);
    filtered = filter(filters(i).Numerator, filters(i).Denominator, data);
    plot_time_frequency_domain(filtered, output_fs, ['Filter output in time ' freq_range_plt(i,:)], ['Filter output in frequency ' freq_range_plt(i,:)]);
    acc_filtered = filtered * (10 ^ (gains(i) / 20)) + acc_filtered;
end

acc_filtered = resample(acc_filtered, output_fs, fs); %resample to the output fs
plot_time_frequency_domain(data, original_fs, 'Input in time ', 'Input in freq. ', acc_filtered, output_fs, 'Output in freq.', 'Output in time.');

[file, path] = uiputfile('*.wav');
fullFileName = fullfile(path, file);

audiowrite(fullFileName, acc_filtered, output_fs);
