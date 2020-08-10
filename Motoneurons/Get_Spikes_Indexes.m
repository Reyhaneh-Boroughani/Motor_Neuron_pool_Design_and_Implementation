 Get_Spikes_Indexes
% it updates the list of spike indexes
% Results: itspikes

itspikes = [itspikes,it]; %time indeces of spikes - here to save only the ones that are within our time span

% INTER SPIKE INTERVAL 
FR = ge*(E(it)-RTE(in)) + MFR; % firing rate

if FR > PFR(in)
    FR = PFR(in); %it has a maximum %%%%%%%!!!!!!
end
%in 1/ms (to be consistent)


mu_ISI = 1./FR; % inter-spike interval mean (calculated for all, to avoid NaN values
ISI = mu_ISI.*(1+cv*randn(1)); % add variability to the interspike
% NEW SPIKE
%if round(ISI(ik)/dt)
it = it + round(ISI/dt); %in order to obtain the index we divide by dt

