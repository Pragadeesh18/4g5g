% Set simulation parameters
numSubcarriers = 64; % Number of subcarriers 
numSymbols = 10; % Number of OFDM symbols 
cpLength = 16; % Cyclic prefix length
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
rxSignal = timeDomainDataWithCP + (randn(size(timeDomainDataWithCP)) + 1i * 
randn(size(timeDomainDataWithCP))) / sqrt(2) * 10^(-snrdB / 20);
% Remove cyclic prefix
rxSignalNoCP = rxSignal(cpLength + 1:end, :);
% Perform FFT on each subcarrier
freqDomainData = fft(rxSignalNoCP, numSubcarriers);
% Estimate the channel using known pilot symbols (e.g., in 5G Synchronization Signals) 
pilotIndexes = [7, 21, 43, 57];
pilotSymbols = freqDomainData(pilotIndexes, :);
% Perform channel estimation (simplified: assume known pilot symbols and linear 
interpolation)
channelEstimates = interp1(pilotIndexes, pilotSymbols, 1:numSubcarriers, 'linear', 
'extrap');
% Demodulate BPSK symbols using channel estimates
estimatedSymbols = real(channelEstimates) > 0; % BPSK demodulation
% Calculate bit error rate (BER)
ber = sum(txData ~= estimatedSymbols(:)) / (numSubcarriers * numSymbols);
% Display results
disp(['Bit Error Rate (BER): ' num2str(ber)]);
disp(['Number of Errors: ' num2str(sum(txData ~= estimatedSymbols(:)))]);
%OUTPUT:
%channelestimation
%Bit Error Rate (BER): 0.4859
%Number of Errors: 311
