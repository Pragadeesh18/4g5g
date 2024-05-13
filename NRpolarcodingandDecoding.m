s = rng(100); % Seed the RNG for repeatability
%Specify the code parameters used for a simulation.
% Code parameters
K = 54; % Message length in bits, including CRC, K > 30 
E = 124; % Rate matched output length, E <= 8192
EbNo = 0.8; % EbNo in dB
L = 8; % List length, a power of two, [1 2 4 8] 
numFrames = 10; % Number of frames to simulate
linkDir = 'DL'; % Link direction: downlink ('DL') OR uplink ('UL') 
if strcmpi(linkDir,'DL')
% Downlink scenario (K >= 36, including CRC bits)
crcLen = 24; % Number of CRC bits for DL, Section 5.1, [6] 
poly = '24C'; % CRC polynomial
nPC = 0; % Number of parity check bits, Section 5.3.1.2, [6] 
nMax = 9; % Maximum value of n, for 2^n, Section 7.3.3, [6] 
iIL = true; % Interleave input, Section 5.3.1.1, [6]
iBIL = false; % Interleave coded bits, Section 5.4.1.3, [6] 
else
% Uplink scenario (K > 30, including CRC bits) 
crcLen = 11;
poly = '11';
nPC = 0;
nMax = 10; 
iIL = false; 
iBIL = true; 
end
%Polar Encoding
R = K/E; % Effective code rate
bps = 2; % bits per symbol, 1 for BPSK, 2 for QPSK 
EsNo = EbNo + 10*log10(bps);
snrdB = EsNo + 10*log10(R); % in dB 
noiseVar = 1./(10.^(snrdB/10));
% Channel
chan = comm.AWGNChannel('NoiseMethod','Variance','Variance',noiseVar);
%polor decoding
% Error meter
ber = comm.ErrorRate; 
numferr = 0;
for i = 1:numFrames
% Generate a random message 
msg = randi([0 1],K-crcLen,1);
% Attach CRC
msgcrc = nrCRCEncode(msg,poly);
% Polar encode
encOut = nrPolarEncode(msgcrc,E,nMax,iIL); 
N = length(encOut);
% Rate match
modIn = nrRateMatchPolar(encOut,K,E,iBIL);
% Modulate
modOut = nrSymbolModulate(modIn,'QPSK');
% Add White Gaussian noise 
rSig = chan(modOut);
% Soft demodulate
rxLLR = nrSymbolDemodulate(rSig,'QPSK',noiseVar);
% Rate recover
decIn = nrRateRecoverPolar(rxLLR,K,N,iBIL);
% Polar decode
decBits = nrPolarDecode(decIn,K,E,L,nMax,iIL,crcLen);
% Compare msg and decoded bits
errStats = ber(double(decBits(1:K-crcLen)), msg); 
numferr = numferr + any(decBits(1:K-crcLen)~=msg);
end
disp(['Block Error Rate: ' num2str(numferr/numFrames) ...
', Bit Error Rate: ' num2str(errStats(1)) ...
', at SNR = ' num2str(snrdB) ' dB'])
rng(s); % Restore RNG
%OUTPUT:
%>> polarcoding1
%Block Error Rate: 0, Bit Error Rate: 0, at SNR = 0.20002 dB
