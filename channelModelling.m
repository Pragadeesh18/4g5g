% 5G Channel Modeling
% Set simulation parameters
numSamples = 1000; % Number of samples 
numTxAnts = 2; % Number of transmit antennas 
numRxAnts = 2; % Number of receive antennas
carrierFreq = 3.5e9; % Carrier frequency in Hz (3.5 GHz) 
sampRate = 15.36e6; % Sampling rate in Hz (15.36 MHz)
% Create a 5G NR channel configuration 
channel = nrTDLChannel; 
channel.NumTransmitAntennas = numTxAnts; 
channel.NumReceiveAntennas = numRxAnts; 
channel.DelayProfile = 'CDL-D'; 
channel.DelaySpread = 30e-9; 
channel.CarrierFrequency = carrierFreq; 
channel.SampleRate = sampRate; 
channel.NormalizePathGains = true;
% Generate random QPSK symbols
data = randi([0, 3], numSamples, numTxAnts);
% Modulate the symbols using QPSK modulation 
modulatedData = qammod(data, 4, 'UnitAveragePower', true);
% Pass the modulated signal through the channel 
channelOutput = channel(modulatedData);
% Calculate the received signal power per receive antenna 
rxPowerPerAntenna = sum(abs(channelOutput).^2) / numSamples;
% Display received power for each antenna 
disp('Received Power per Antenna:'); 
disp(rxPowerPerAntenna);
% Plot the channel impulse response for the first receive antenna figure; 
plot(0:numSamples-1, abs(channelOutput(:, 1)));
title('Channel Impulse Response (First Receive Antenna)'); 
xlabel('Sample Index');
ylabel('Magnitude');
% Plot the frequency response for the first receive antenna figure; 
freqz(channelOutput(:, 1));
title('Channel Frequency Response (First Receive Antenna)');
%{
Channel modelling
Received Power per Antenna: 
1.3151 1.1736 + 2 Graphs
} 
