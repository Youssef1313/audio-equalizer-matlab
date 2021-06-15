function plot_time_frequency_domain(data, fs, title_time, title_freq, varargin)
    sub_plots = 1;
    f = figure;
    f.Position = [100 100 540 400];
    if nargin > 5
        sub_plots = 2;
        length_output = length(varargin{1});
        df = varargin{2} / length_output;
        frequency_audio = -varargin{2}/2 : df : varargin{2}/2-df;
  
        not_shifted_output_fft = fft(varargin{1}); 
        fft_data = fftshift(not_shifted_output_fft) / length(not_shifted_output_fft);

        subplot(2, sub_plots , 3);
        plot(frequency_audio, abs(fft_data));
        title(varargin{3});
        xlabel('Frequency(Hz)');
        ylabel('Amplitude');

        subplot(2, sub_plots, 4);
        t = (0:length_output-1)/ varargin{2};
        plot(t, varargin{1})
        title(varargin{4});
        xlabel('Time(s)');
        ylabel('Amplitude');
    end
    
    length_data = length(data);
    df = fs / length_data;
    frequency_audio = -fs/2 : df : fs/2-df;
    not_shifted_fft = fft(data);
    fft_data = fftshift(not_shifted_fft) / length(not_shifted_fft);
    
    subplot(2, sub_plots, 1);
    plot(frequency_audio, abs(fft_data));
    title(title_freq);
    xlabel('Frequency(Hz)');
    ylabel('Amplitude');

    subplot(2, sub_plots, 2);
    t = (0:length_data-1)/ fs;
    plot(t, data)
    title(title_time);
    xlabel('Time(s)');
    ylabel('Amplitude');
end
