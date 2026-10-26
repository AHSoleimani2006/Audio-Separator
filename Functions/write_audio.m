function write_audio(vector_of_samples  ,  Fs , name_of_file)

% write_audio(vector_of_samples  ,  Fs)
%
% This function converts the vector into an audio file. The fomat of the
% file is ".wav" and it is saved in the folder 
%               "./S&S MATLAB HW Package/Outputs/"
%
% "vector_of_samples" is a vector that contains the samples of an audio
% file. It can be either vertical or horizontal. If the elements are
% complex, the imaginary parts will be ignored.
%
% "Fs" is the sampling frequency (HZ) which is used for sampling the audio 
% signal. If this input is not given, it is set to 44.1KHz by default.
%
% "name_of_file" is a string that defines the name of final audio file.
%
%
% Example:
%               Fs      = 8000;  % sampling rate is 8KHz
%               tt      = linspace(0 , 10 , Fs);   % the time instants for a 10s audio signal
%               samples = sin(2*pi* 1000 * tt);    % a monotone signal with 1KHz frequency
%               write_audio(samples  ,  Fs , 'test');


LLL             = size(vector_of_samples);
if length(LLL) > 2
    error('     !!! Error: The "vector_of_samples" should be a vector !!!')

elseif length(LLL) == 1
    samples     = reshape(vector_of_samples , length(vector_of_samples) , 1);
    
else
    if LLL(1) > LLL(2)
        samples = vector_of_samples(:,1);
    else
        samples = vector_of_samples(1,:).';
    end
    
end

if max(abs(imag(samples))) > 0
    disp('      *** Warning: The elements in "vector_of_samples" are not purely real ***')
    samples     = real(samples);
end



if nargin == 1
    Fs          = 44.1e3;
    name_of_file= 'untitled';
    
elseif nargin == 2
    name_of_file= 'untitled';
end



% scale the audio input to maximize the volume
samples         = 0.999 * samples / max(abs(samples));



% setting the directory
Current_Folder  = pwd;
%saving_dir      = [Current_Folder(1:end-9) , 'Outputs/'];
saving_dir      = ['./Outputs/'];

% saving the file
audiowrite([saving_dir , name_of_file] , [samples,samples] , Fs)