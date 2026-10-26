function sampling = Fourier_Samples(Freq_vector , audio_vector , Fs)

sampling = zeros(size(Freq_vector));

N = length(audio_vector);
t = (0:N-1)' / Fs;

% Fourier Transform
for k = 1:length(Freq_vector)
    f = Freq_vector(k);
    
    sampling(k) = (1/Fs) * sum(audio_vector .* exp(-1j * 2 * pi * f * t));
end
end