fc = 28e9; %carrier frequency
fs = 30e9; %sampling frequency 
N = 1024; %number ofsamples
t =0:1/fs:N/fs-1/fs; %time vector 
x = cos(2*pi*fc*t); %signal
figure;
plot(t,x);
title(‘5G Compliant
Signal’); xlabel(‘Time
(s)’); ylabel(‘Amplitude’);
%Testing of 5G compliant signal
%Define the parameters
fc_test = 28e9; %carrier frequency 
fs_test = 30e9; %sampling frequency 
N_test = 1024; %number ofsamples
%Generate the signal
t_test =0:1/fs_test:N_test/fs_test-1/fs_test; %time vector 
x_test = cos(2*pi*fc_test*t_test); %signal
%Calculate the powerspectral density
[Pxx,f] = periodogram(x_test,[],N_test,fs_test);
%Plot thepowerspectral density 
figure;
plot(f,Pxx);
title(‘Power Spectral Density of 5G Compliant Signal’); 
xlabel(‘Frequency (Hz)’);
ylabel(‘Power Spectral Density (Db/Hz)’)
