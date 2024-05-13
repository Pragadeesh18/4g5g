cfgDL = nrDLCarrierConfig; 
cfgDL.Label = 'Carrier1'; 
cfgDL.FrequencyRange = 'FR1'; 
cfgDL.ChannelBandwidth = 50;
cfgDL.NCellID = 1;
cfgDL.NumSubframes = 10;
cfgDL.WindowingPercent = 0; 
cfgDL.SampleRate = []; 
cfgDL.CarrierFrequency = 0;
%% SCS specific carriers 
scscarrier = nrSCSCarrierConfig; 
scscarrier.SubcarrierSpacing = 15;
scscarrier.NSizeGrid = 270;
scscarrier.NStartGrid = 3; 
cfgDL.SCSCarriers = {scscarrier};
%% Bandwidth Parts
bwp = nrWavegenBWPConfig; 
bwp.BandwidthPartID = 1; 
bwp.Label = 'BWP1'; 
bwp.SubcarrierSpacing = 15; 
bwp.CyclicPrefix = 'normal'; 
bwp.NSizeBWP = 270;
bwp.NStartBWP = 3; 
cfgDL.BandwidthParts = {bwp};
%% Synchronization Signals Burst 
ssburst = nrWavegenSSBurstConfig; 
ssburst.Enable = true;
ssburst.Power = 0; 
ssburst.BlockPattern = 'Case A';
ssburst.TransmittedBlocks = ones([1 4]); 
ssburst.Period = 20;
ssburst.NCRBSSB = []; 
ssburst.KSSB = 0; 
ssburst.DataSource = 'MIB'; 
ssburst.DMRSTypeAPosition = 2; 
ssburst.CellBarred = false; 
ssburst.IntraFreqReselection = false; 
ssburst.PDCCHConfigSIB1 = 0;
ssburst.SubcarrierSpacingCommon = 15; 
cfgDL.SSBurst = ssburst;
%% CORESET and Search Space Configuration
% CORESET 1
coreset1 = nrCORESETConfig; 
coreset1.CORESETID = 0; 
coreset1.Label = 'CORESET0';
coreset1.FrequencyResources = ones([1 8]); 
coreset1.Duration = 2; 
coreset1.CCEREGMapping = 'interleaved'; 
coreset1.REGBundleSize = 6;
coreset1.InterleaverSize = 2;
coreset1.ShiftIndex = 0;
coreset1.PrecoderGranularity = 'sameAsREG-bundle'; 
coreset1.RBOffset = [];
% CORESET 2
coreset2 = nrCORESETConfig; 
coreset2.CORESETID = 1; 
coreset2.Label = 'CORESET1';
coreset2.FrequencyResources = ones([1 8]); 
coreset2.Duration = 2; 
coreset2.CCEREGMapping = 'interleaved'; 
coreset2.REGBundleSize = 6;
coreset2.InterleaverSize = 2;
coreset2.ShiftIndex = 0;
coreset2.PrecoderGranularity = 'sameAsREG-bundle'; 
coreset2.RBOffset = [];
cfgDL.CORESET = {coreset1,coreset2};
% Search Spaces
searchspace = nrSearchSpaceConfig; 
searchspace.SearchSpaceID = 1; 
searchspace.Label = 'SearchSpace1'; 
searchspace.CORESETID = 1; 
searchspace.SearchSpaceType = 'ue'; 
searchspace.StartSymbolWithinSlot = 0;
searchspace.SlotPeriodAndOffset = [1 0];
searchspace.Duration = 1;
searchspace.NumCandidates = [8 8 4 2 1]; 
cfgDL.SearchSpaces = {searchspace};
%% PDCCH Instances Configuration 
pdcch = nrWavegenPDCCHConfig; 
pdcch.Enable = true;
pdcch.Label = 'PDCCH1'; 
pdcch.Power = 0;
pdcch.BandwidthPartID = 1;
pdcch.SearchSpaceID = 1;
pdcch.AggregationLevel = 8;
pdcch.AllocatedCandidate = 1; 
pdcch.CCEOffset = []; 
pdcch.SlotAllocation = 0;
pdcch.Period = 1; 
pdcch.Coding = true; 
pdcch.DataBlockSize = 20; 
pdcch.DataSource = 'PN9-ITU'; 
pdcch.RNTI = 1;
pdcch.DMRSScramblingID = 2;
pdcch.DMRSPower = 0; 
cfgDL.PDCCH = {pdcch};
%% PDSCH Instances Configuration 
pdsch = nrWavegenPDSCHConfig; 
pdsch.Enable = true;
pdsch.Label = 'PDSCH1'; 
pdsch.Power = 0;
pdsch.BandwidthPartID = 1; 
pdsch.Modulation = 'QPSK'; 
pdsch.NumLayers = 1; 
pdsch.MappingType = 'A'; 
pdsch.ReservedCORESET = []; 
pdsch.SymbolAllocation = [0 14];
pdsch.SlotAllocation = 0:9;
pdsch.Period = 10;
pdsch.PRBSet = 0:269;
pdsch.VRBToPRBInterleaving = 0;
pdsch.VRBBundleSize = 2;
pdsch.NID = 1;
pdsch.RNTI = 1; 
pdsch.Coding = true;
pdsch.TargetCodeRate = 0.513671875;
pdsch.TBScaling = 1;
pdsch.XOverhead = 0;
pdsch.RVSequence = [0 2 3 1];
pdsch.DataSource = 'PN9-ITU'; 
pdsch.DMRSPower = 0; 
pdsch.EnablePTRS = false; 
pdsch.PTRSPower = 0;
% PDSCH Reserved PRB
pdschReservedPRB = nrPDSCHReservedConfig; 
pdschReservedPRB.PRBSet = []; 
pdschReservedPRB.SymbolSet = []; 
pdschReservedPRB.Period = [];
pdsch.ReservedPRB = {pdschReservedPRB};
% PDSCH DM-RS
pdschDMRS = nrPDSCHDMRSConfig; 
pdschDMRS.DMRSConfigurationType = 1; 
pdschDMRS.DMRSReferencePoint = 'CRB0'; 
pdschDMRS.DMRSTypeAPosition = 2;
pdschDMRS.DMRSAdditionalPosition = 0;
pdschDMRS.DMRSLength = 1; 
pdschDMRS.CustomSymbolSet = []; 
pdschDMRS.DMRSPortSet = []; 
pdschDMRS.NIDNSCID = []; 
pdschDMRS.NSCID = 0;
pdschDMRS.NumCDMGroupsWithoutData = 2;
pdschDMRS.DMRSDownlinkR16 = 0; 
pdsch.DMRS = pdschDMRS;
% PDSCH PT-RS
pdschPTRS = nrPDSCHPTRSConfig; 
pdschPTRS.TimeDensity = 1;
pdschPTRS.FrequencyDensity = 2;
pdschPTRS.REOffset = '00'; 
pdschPTRS.PTRSPortSet = [];
pdsch.PTRS = pdschPTRS; 
cfgDL.PDSCH = {pdsch};
%% CSI-RS Instances Configuration 
csirs = nrWavegenCSIRSConfig; 
csirs.Enable = false;
csirs.Label = 'CSIRS1'; 
csirs.Power = 0;
csirs.BandwidthPartID = 1; 
csirs.CSIRSType = 'nzp'; 
csirs.CSIRSPeriod = 'on'; 
csirs.RowNumber = 3; 
csirs.Density = 'one'; 
csirs.SymbolLocations = 0;
csirs.SubcarrierLocations = 0;
csirs.NumRB = 52;
csirs.RBOffset = 0;
csirs.NID = 0; 
cfgDL.CSIRS = {csirs};
% Generation
[waveform,info] = nrWaveformGenerator(cfgDL);
Fs = info.ResourceGrids(1).Info.SampleRate;
% Specify the sample rate of the waveform in Hz
%% Visualize
% Spectrum Analyzer
spectrum = spectrumAnalyzer('SampleRate', Fs); 
spectrum(waveform);
release(spectrum); 
