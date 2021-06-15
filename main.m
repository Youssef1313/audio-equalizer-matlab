close all;
clear;

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

if strcmp('fir', filter_type)
    fir_order = 150;
    filters = fir_filters(fir_order, fs, bands);
else
    iir_order = 4;
    filters = iir_filters(iir_order, fs, bands);
end

acc_filtered = data .* 0;

freq_range_plt = [' 0-170  Hz'; '170-310 Hz'; '310-600 Hz'; '0.6-1  kHz'; '1-3    kHz'; '3-6    kHz'; '6-12   kHz'; '12-14  kHz'; '14-16  KHZ'];
for i = 1:length(filters)
    plot_requirements(filters(i), fs, [mat2str(bands(i,:)) 'Hz']);
    filtered = filter(filters(i).Numerator, filters(i).Denominator, data);
    plot_time_frequency_domain(filtered, fs, ['Output in time-domain for filter ' freq_range_plt(i,:)], ['Output in frequency-domain for filter ' freq_range_plt(i,:)]);
    acc_filtered = acc_filtered + filtered * db2mag(gains(i));
    [z, p, k] = tf2zpk(filters(i).Numerator, filters(i).Denominator);
    order = filtord(filters(i).Numerator, filters(i).Denominator);
    fprintf('The gain of %s filter : %s  is %f , Order is %d \n',filter_type, freq_range_plt(i,:), k, order);
end

acc_filtered = resample(acc_filtered, output_fs, fs); % resample to the output fs
plot_time_frequency_domain(data, original_fs, 'Input in time ', 'Input in freq. ', acc_filtered, output_fs, 'Output in freq.', 'Output in time.');

[file, path] = uiputfile('*.wav');
fullFileName = fullfile(path, file);

audiowrite(fullFileName, acc_filtered, output_fs);
