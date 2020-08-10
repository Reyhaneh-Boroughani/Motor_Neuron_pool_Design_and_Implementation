function [E_struct,SpikeTrain_struct,Fp_struct,emg_struct] = Chose_Excitation(duration,lower_limit,upper_limit,numE,numtrial,input_type,lable,muap_pool1, init_val, end_val, st)
% Function to perform multiple simulations at once, with a defined range of
% excitations and the possibility of multiple trials. It first generates
% the spike trains and then it creates an EMG signal using pool of MUAPs
% coming from a model previously defined. It stores everything in
% structures.
%
% INPUT:
%   - duration:     (total) duration of the excitation signals (E)
%   - lower_limit:  lower limit of the amplitude of E in the range
%   - upper_limit:  upper limit of the range of E
%   - numE:         #amplitudes to test within lower and upper limit
%   - numtrial:     #repetions for each same E signal
%   - input_type:   type of excitation ('unitstep', 'ramp', 'ramp_hold', unitstep_ramp',
%                                       'unitstep_ramp_hold')
%   - label:        label to store all signals generated in the loop
%   - muap pool:    MUAP previously generated for a random configuration
%   - init_val:     initial value of the excitation (used for some signals)
%   - end_val:      end value of excitation ("")
%
% OUTPUT: Structures with {trial,excitation}
%   - E_struct:          {E_amp(i), duration, input_type, lable}
%   - SpikeTrain_struct: 
%   - Fp_struct:        
%   - emg_struct:

E_struct=cell(numtrial,numE);
SpikeTrain_struct=cell(numtrial,numE);
Fp_struct=cell(numtrial,numE);
emg_struct=cell(numtrial,numE);

E_amp=linspace(lower_limit,upper_limit,numE);

addpath('./sEMG');
addpath('./Motoneurons');
addpath('./Force');

if ~exist('init_val','var')
    init_val = 0;
    end_val = 1;
    st = 0;
end

for i=1:length(E_amp)
    for triali=1:numtrial
        
        Defining_Parameters
        
    E_aux= E_amp(i)*Input_Current(input_type,duration, [init_val, end_val],st); %%stires different E_aux for further simulations, right now manual lables!!
    E_struct{triali,i} = {E_amp(i), duration, input_type, lable};
    
    Nt = size(E_aux,2);
    t = 0:dt:dt*(Nt-1);
    E = E_aux;
    
    Firing_Recording_sEMG
  
    %%Saving data in cell, then we want these in a structure
    SpikeTrain_struct{triali,i}=SpikeTrain;
    Fp_struct{triali,i}=Fp;
    emg_struct{triali,i}=emg;
    
    end
end
end

