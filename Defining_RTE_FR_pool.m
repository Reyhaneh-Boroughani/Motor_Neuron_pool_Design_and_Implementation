%% Defining_RTE_FR_pool
% Recruitment threshold excitation - RTE
RR = 30; a = (1/np)*log(RR); % RR: range of activations 
RTE = exp(a.*(1:np))'; %column form
PFR = PFR1 - PFRD*(RTE./RTE(np));

% for Izhikevich
E_PFR = E_PFR1.*PFR./(PFR1)+(RTE-1.4051);