function plot_time_frequency_domain(data, fs)
    length_data = length(data);
    df = fs / length_data;
    frequency_audio = -fs/2 : df : fs/2-df;
    figure;
    fft_data = fftshift(fft(data)) / length(fft(data));
    plot(frequency_audio, abs(fft_data));
    title('FFT of Input Audio');
    xlabel('Frequency(Hz)');
    ylabel('Amplitude');

    % TODO: Plot time domain in the same figure (2 subplots)
end
