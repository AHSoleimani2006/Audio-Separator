function output_sampling = voice_siren_separator(samples , Fs)

samples = samples(:);
N = length(samples);

% DFT
X = fft(samples);

frequencies = (0:N-1)' * (Fs / N);
neg_frequencies = frequencies >= Fs/2;
frequencies(neg_frequencies) = frequencies(neg_frequencies) - Fs;

% Band width design
f_low  = 700;
f_high = 2000;

filtered = (abs(frequencies) >= f_low) & (abs(frequencies) <= f_high);
X(filtered) = 0;

output_sampling = ifft(X, 'symmetric');
end