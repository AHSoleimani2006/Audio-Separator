clc; clear; close all;

addpath('Functions');

% The location of the source file
source_file = './Audio Input/PoliceTalk_siren.wav';


%% Read and play the audio file
[audio_vector , Fs]  = audioread(source_file);
% audio_vector: contains the samples of the audio signal
% Fs: sampling frequency in Hz

% converting Stereo to Mono (for the sake of simplicity, we remove one channel)
audio_vector = audio_vector(: , 1);


% playing the audio signal
disp('--- You are listening to the original audio file ---');
play_audio(audio_vector , Fs);
disp('-------------------- End of file -------------------');
disp(' ');


%% Fourier Transform
% Frequency Interval
Freq_vector = linspace(-10e3 , 10e3 , 1e3+1);

% Fourier transform
audio_Fourier = Fourier_Samples(Freq_vector , audio_vector , Fs);

% Plot fouerier transform (original file)
subplot(2,1,1)
plot(Freq_vector , abs(audio_Fourier))
ylabel('Magnitude')
title('Original Audio signal')
subplot(2,1,2)
plot(Freq_vector , phase(audio_Fourier))
ylabel('phase')
xlabel('Frequency (Hz)')

% save the figure
savefig('./Outputs/Source_Fourier.fig')

disp('Wait...');
pause(3);
disp(' ');


%% Filter
% filter siren out
separated_signal = voice_siren_separator(audio_vector , Fs);

% play the output
disp('--- You are listening to the processed audio file ---');
play_audio(separated_signal , Fs);
disp('-------------------- End of file --------------------');
disp(' ');

% save the processed audio signal
write_audio(separated_signal  ,  Fs , 'processed.wav');


% Plot fouerier transform (processed file)
separated_Fourier = Fourier_Samples(Freq_vector , separated_signal , Fs);

figure;
subplot(2,1,1);
plot(Freq_vector , abs(separated_Fourier));
ylabel('Magnitude');
title('Processed Audio signal');
subplot(2,1,2);
plot(Freq_vector , phase(separated_Fourier));
ylabel('phase');
xlabel('Frequency (Hz)');

% saving the figure
savefig('./Outputs/Processed_Fourier.fig')
