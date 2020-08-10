%% Neural Prostheses %%
% M.Sc. in Bionics Engineering 
% 
% Final Project / A.Y. 2019/2020 / Second Semester

% Project:
% Design and implementation of a model of motor neuron pools performing 
% movements to test online decoding algorithms based on intrafascicular 
% (or EMG) recordings

%% Tonic_Spiking %%
% Simulation Neuro biological response

% Tonic Spiking
% Most neurons are excitable, that is, they are quiescent but can
% fire spikes when stimulated. 
% While a constant input is on, the neuron continues to fire a train of 
% spikes. This kind of behavior, called tonic spiking.


% NOTE:
%   The values of the Izhikevich’s model parameters and the shape of the 
%   input were taken from the following .m file:
%   http://izhikevich.org/publications/figure1.m

%%%%%%%%%%%%%%%%%%%%%%%
%Simulation parameters
%%%%%%%%%%%%%%%%%%%%%%%

% Simulation_Parameters;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Izhikevich’s model parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%
%Input Current
%%%%%%%%%%%%%%
cr = 0;         % No Model Equations correction (see notes on Izhikevich.m file)

I_m = 4;     % Max current

% 22.5 ->   ~55
% 12.5 ->   ~26
% 5 ->      ~10
%Input amplitude
I = I_m*I;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Izhikevich's Model function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[u,w, itspikesMN] = Izhikevich(a,b,c,d,u0,cr,I,r,it);


%%%%%%%%%%
% Plotting
%%%%%%%%%%