%% IMPORTANT NOTES
% [t]: in ms
% [x]: in mm
% [cond]: in S/mm (ohm^-1 mm^-1)
% [V]: in V
% [I]: in kA (but we do the correction within the code)

%% PHYSIOLOGICAL PARAMETERS (OF A SINGLE POOL)
totalnumpools = 1;
mnp = 100;  %motoneurons in this pool;
Nn = [mnp];

% twitch pool
RP = 100; % range of peak amplitudes;
RT = 3; % range of contraction times (NOT in ms!!)
TL = 90; % longest contraction time for the twitch (ms)
Defining_Twitch_Pool 

% RTE and FR
% Firing rate - FR
PFR1 = 45*1E-3; % (Hz) peak firing rate 1st neuron
PFRD = 10*1E-3; % (Hz) desired difference between first and last neuron

MFR = 8*1E-3; %(Hz) minimum firing rate: constant for all neurons
ge = 0.675*10E-3; % gain of the excitatory drive above RTE (slope) (number aproximated from the figure in the slides

% muscle
Rm = 5; % radius of the muscle (mm)
density_fibers = 20; %Density of fibers within the muscles (fibers/mm2) FIXED
nft = 1200; % total number of fibers
overlap = 0.5; %can motoneurons territories overlap? (1: total overlapping | 0: no overlapping);
rf = 28E-3; %radius fibers (mm)
zfconst = -40; %endplate fiber (mm)
Lhalf = 120; % L/2 half fiber length (mm)
Tdecay = 6; %the dipole current decays exponentially at the fiber termination (ms)

% muap
bss = 0.5; %distance between current source and sink in the fiber (constant) (mm)
I = 388E-6; %in A (originally 388 mA -F92)
I = I*10-3; % to compensate for the fact that we work in ms
velprop_min = 2.5; velprop_max = 5.5; %velocity of propagation (m/s or mm/ms)

% Anisotropy
cond_z = 0.33*1E-3; cond_r = 0.063*1E-3; %conductivity: z (along the fiber direction) in mhos/mm (or 	) - F92
%% EXPERIMENTAL PARAMETERS
Rs = Rm; %Radius considering also the skin
pos_el{1} = [0 Rs 0]; %we have 2 electrodes
dt = 0.1; %time resolution (ms)

% MUAP construction
TfTempl = 100; %(ms) final time for the spike templates construction

%% Izhikevich
type = 1; %1: tonic spiking / 2: class1
RandNoiseIzh = 0.1;
E_PFR1 = 6.16;
var_I = 0.2;
%% Fuglevand 1993
cv = 0; %coef variability (std/mean) of ISI
%% Plots flags
flagMNTerritories = 0;
flagIzh = 0;