%% Betthauser - 2016 --  filter raw multichannel EMG
% INPUTS: rawEMG - raw EMG data (number_of_channels x number_of_samples)
%         samplingFreq - sampling frequency (Hz)    
%         lowFcutoff - low frequency high-pass cutoff (Hz)
%         hiFcutoff - high frequency low-pass cutoff (Hz)
% 
% OUTPUT: filtEMG - filtered EMG (number_of_channels x number_of_samples)
%
% TYPICAL EMG USE EXAMPLE: filtEMG = filterEMG(rawEMG, 1000, 20, 450)
%
% REFERENCES AND NUMBERS:
%scheme 2011 uses 20hz high pass 3rd order butter and 5th order low pass at 500hz
%young 2011 uses 20 hz high pass 3rd order butter
%scheme 2013 uses low pass at 450hz with 5th order butter
%radmand 2013 uses 60 hz notch using 3rd order butter
function filtEMG = filterEMG(rawEMG, samplingFreq, lowFcutoff, hiFcutoff) 
    means = mean(rawEMG,2);
    for i = 1:size(rawEMG,1) %for each of the 8 channels...
        rawEMG(i,:) = rawEMG(i,:)-means(i);
    end
    %create and apply bandpass filter
    lowerBound = lowFcutoff; %Hz
    upperBound = hiFcutoff; %Hz
    Fs = samplingFreq; %1kHz
    d = fdesign.bandpass('N,F3dB1,F3dB2',4,lowerBound,upperBound,Fs); %young 2011 uses 20 hz high pass 3rd order butter
    bandpassFilt = design(d,'butter');
    % fvtool(bandpassFilt);
    BPfilteredEMG = filter(bandpassFilt,rawEMG')';
    %create and apply notch filter
    d = designfilt('bandstopiir','FilterOrder',4, ...
                   'HalfPowerFrequency1',59,'HalfPowerFrequency2',61, ...
                   'DesignMethod','butter','SampleRate',Fs);
    % fvtool(d,'Fs',Fs); % Plot the frequency response of the filter. Note that this notch filter provides up to 45 dB of attenuation.
    filtEMG = filter(d,BPfilteredEMG')';  
end