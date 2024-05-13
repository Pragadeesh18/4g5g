% Set simulation parameters
numSubcarriers = 64; % Number of subcarriers 
numSymbols = 10; % Number of OFDM symbols 
numGuard = 6; % Number of guard subcarriers 
cpLength = 16; % Cyclic prefix length 
channelDelay = 3; % Channel delay in samples 
snrdB = 20; % Signal-to-noise ratio in dB
% Generate BPSK symbols
txData = randi([0, 1], numSubcarriers * numSymbols, 1); 
modulatedData = 2 * txData - 1;
% Reshape modulated data into subcarriers
dataMatrix = reshape(modulatedData, numSubcarriers, numSymbols);
% Perform IFFT on each subcarrier 
timeDomainData = ifft(dataMatrix, numSubcarriers);
% Add cyclic prefix
cyclicPrefix = timeDomainData(end - cpLength + 1:end, :); 
timeDomainDataWithCP = [cyclicPrefix; timeDomainData];
% Transmit the time-domain signal through a channel (simulated with delay and noise) 
channelOutput = [zeros(channelDelay, numSymbols); timeDomainDataWithCP]; 
rxSignal = channelOutput + (randn(size(channelOutput)) + 1i * 
randn(size(channelOutput))) / sqrt(2) * 10^(-snrdB / 20);
% Remove cyclic prefix
rxSignalNoCP = rxSignal(cpLength + 1:end, :);
% Perform FFT on each subcarrier
freqDomainData = fft(rxSignalNoCP, numSubcarriers);
% Demodulate BPSK symbols
demodulatedData = real(freqDomainData(:)) > 0; % BPSK demodulation
% Calculate bit error rate (BER)
ber = sum(txData ~= demodulatedData) / (numSubcarriers * numSymbols);
% Display results
disp(['Bit Error Rate (BER): ' num2str(ber)]);
disp(['Number of Errors: ' num2str(sum(txData ~= demodulatedData))]);
%{
OFDM demodulation
Bit Error Rate (BER): 0.50156 
Number of Errors: 321
}
