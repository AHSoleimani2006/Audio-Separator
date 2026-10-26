# Frequency-Based Audio Separator

This project focuses on isolating a police officer's voice from a background siren using frequency-selective filtering. Because the siren's loud noise obscures the officer's speech, we have used a low-pass filter to extract and remove the high-frequency bands associated with the siren. 

## Mathematical Background
To visualize the signal's real-world frequencies, the continuous-time Fourier transform (CTFT) is approximated rather than relying solely on the standard discrete Fourier transform (DFT). The approximation maps discrete samples to physical frequencies using the following formula:

$$\hat{x}(j2\pi f)\approx\frac{1}{F_{s}}\sum_{n=0}^{N-1}x[n]e^{-j2\pi f(\frac{n}{F_{s}})}$$

## Filtering Methodology
* The input signal is transformed into the frequency domain using the Fast Fourier Transform (`fft`).
* Analysis of the input signal's Fourier transform shows that the siren's frequencies have large amplitudes starting above 800 Hz, peaking around 1600 Hz.
* The officer's voice primarily occupies the lower frequency spectrum, with fundamental male voice frequencies around 80 to 180 Hz.
* A band-stop filter is applied between 700 Hz and 2000 Hz to eliminate the siren's primary harmonics while minimizing damage to the speech signal.
* The modified frequency data is converted back to the time domain using the Inverse Fast Fourier Transform (`ifft`).

## Core Logic Snippet
The filtering is achieved by zeroing out the specified frequency range within `voice_siren_separator.m` (The filter used is considered to be ideal):
```matlab
f_low = 700;
f_high = 2000;
filtered = (abs(frequencies) >= f_low) & (abs(frequencies) <= f_high);
X(filtered) = 0;
output_sampling = ifft(X, 'symmetric');
