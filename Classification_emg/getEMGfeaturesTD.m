%% Betthauser - 2016 --  get EMG TD5 features for a window of EMG
% INPUTS: filtEMG - EMG data (number_of_channels x number_of_samples)
%         zcoreEnable - zscores each EMG channel to mean=0 and std=0
%              >> Usually off, but can sometimes improve accuracy
%              >> However, must also score all new samples x: z=(x-dataMeans)/dataStds
% 
% OUTPUT: EMGobj - object holding EMG TD5 features per channel
%         EMGobj.MAV - mean-absolute-value (number_of_channels x number_of_samples)
%         EMGobj.WL - waveforem length (" " x " ") 
%         EMGobj.VAR - variance (" " x " ") 
%         EMGobj.SSC - slope-sign-change (" " x " ") 
%         EMGobj.ZC - zero crossings (" " x " ") 
%
% TYPICAL EMG USE EXAMPLE: EMGobj = getEMGfeaturesTD(filtEMG, 0);
function [EMGobj] = getEMGfeaturesTD(filtEMG)
    numEMGchannels = size(filtEMG,1);
    epsZC = 0.000001;   %you need to determine this!!! the optimal val may be different across subjects
    epsSSC = 0.000001;  %you need to determine this!!! the optimal val may be different across subjects
    
    %     tic
    for i = 1:numEMGchannels % for each channel
        sample = filtEMG(i,:);
        window = length(sample);
        
         %% Variance (VAR)
        EMGobj.VAR(i,1) = var(sample);                
         %% Mean Absolute Value (MAV)
        EMGobj.MAV(i,1) = mean(abs(sample));
         %% Waveform Length (WL)
        temp_WL = 0;
        for k = 2:window
            temp_WL = temp_WL + abs(sample(k)-sample(k-1));
        end
        EMGobj.WL(i,1) = temp_WL;        
       
        
         %% Zero Crossings (ZC)
        zcCount = 0;
        for k = 2:window
            zcCount = zcCount+double((sign(sample(k))~=sign(sample(k-1))) .* (abs(sample(k)-sample(k-1))>epsZC) );
        end
        EMGobj.ZC(i,1) = zcCount;
         %% Slope Sign Change (SSC)
        sscCount = 0;
        for k = 2:window-1
            condishStatement = (( sample(k)>sample(k-1) & sample(k)>sample(k+1) ) | ( sample(k)<sample(k-1) & sample(k)<sample(k+1) ))...
                & ( (abs(sample(k)-sample(k+1))>epsSSC) | (abs(sample(k)-sample(k-1))>epsSSC) );
            sscCount = sscCount+double( condishStatement );
        end
        EMGobj.SSC(i,1) = sscCount; 
    end
%     toc
end