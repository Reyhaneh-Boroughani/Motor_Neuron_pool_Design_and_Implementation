%% Neural Prostheses %%
% M.Sc. in Bionics Engineering 
% 
% Final Project / A.Y. 2019/2020 / Second Semester

% Project:
% Design and implementation of a model of motor neuron pools performing 
% movements to test online decoding algorithms based on intrafascicular 
% (or EMG) recordings

%% Izichevich Function Model %%

%   Computational model to simulate the biological neurons 
%   response based on the Izhikevich Model.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Izhikevich's Model Equations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The Izhikevich Model is a two output and five inputs function:

%function [u,w] = Izhikevich(a,b,c,d,iu,cr,I,r,st,it)

% Outputs 
%   u -> Membrane Potential [mV]
%   w -> Recovery variable

% Inputs
%    
%   Parameters for modeling different Biological Neurons responses
%       a -> Time scale of the recovery variable
%       b -> Sensitivity of the recovery variable to fluctuations of u
%       c -> After-spike reset value of u
%       d -> After-spike reset of the recovery variable
%
%   Correction Parameters
%       iu -> Initial Membrane Potential
%       cr -> correction factor to modify the equation model
%
%   Excitation
%       I -> Inyected current
%       r -> Simulation time [ms]

%The Izhikevich's Model function is described by the following equations
%
%   du = alfa*(u^2) + beta*u + gamma - w + I
%   dw = a(b*u - w)
%
%Tipical values of alfa(0.04), beta(5) and gamma(140):
%
%   du = 0.04*(u^2) + 5*u + 140 - w + I
%   dw = a(b*u - w)
%
%Some special scenarios need a correction on the equation 
%       alfa(0.04), beta(4.1), and gamma(108)
%
%   du = 0.04*(u^2) + 4.1*u + 108 - w + I
%   dw = a(b*u - w)
%
%   After Spiking Conditions
%       if u >= 30mV
%           u <- c
%           w <- w+ d

%% Implementation %%

function [itspikes] = Izhikevich(type,I,dt, randomNoise, flagPlot)
% u0:
% type: either Class1 or TonicSpiking
% I   : input current
% dt  : time resolution
% plot: Boolean value (1: to plot)
%Izhikevich(a,b,c,d,u0,cr,I,r,it)

% Define parameters from type of neuron
    if type == 1; % 'TonicSpiking'
        a = 0.02;       % Time scale of the recovery variable
        b = 0.2;        % Sensitivity of the recovery variable to fluctuations of u
        c = -65;        % After-spike reset value of u
        d = 6;          % After-spike reset of the recovery variable
        u0 = -70;       % Initial Membrane Potential

        % corrections
        alfa = 0.04;    beta = 5;       gamma = 140;

    elseif type == 2; %'Class1'
        a= 0.02;        % Time scale of the recovery variable
        b= -0.1;        % Sensitivity of the recovery variable to fluctuations of u
        c= -55;         % After-spike reset value of u
        d= 6;           % After-spike reset of the recovery variable
        u0 = -70;

        % corrections
        alfa = 0.04;    beta = 4.1;     gamma = 108;
    else
        error('type can only be TonicSpiking or Class1');
    end
    a = a*(1+randomNoise*rand(1));
    b = b*(1+randomNoise*rand(1));
    d = d*(1+randomNoise*rand(1));
    c = c*(1+randomNoise*rand(1));
    u0 = u0*(1+randomNoise*rand(1));

% Add some variability to the neurons (randomNoise)

    
% Re-scale the input current so that MFR is 8 Hz !!!!!
I = 3.52*I;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nt = size(I,2);
%Initial Conditions
u = zeros(1,Nt); u(1) = u0; % Initial Resting Potential
w = zeros(1,Nt); w(1) = b*u0; % Initial Recovery Variable
spike   = 0;            % Fire condition unset
itspikes = [];


iSpike = 1; %index that keeps track of the spikes
%Run the simulation for input Simulation Time "r[ms]"
for ij=2:Nt
    %t = t_o + ij*h;  % Discrete time
    %cs = it*h;     % Calculation step
   
    %No spike condition
    if spike==0
        %Model equations
        u(ij) = u(ij-1) + dt*(alfa*(u(ij-1)^2)+ beta*u(ij-1) + gamma - w(ij-1) + I(ij-1));
        
        w(ij) = w(ij-1) + dt*(a*(b*u(ij) - w(ij-1)));  
        
        %Spike detection
        if u(ij)>= 30
            u(ij) = 30; %To set a cut-off spike value
            w(ij) = w(ij)+d;
            spike = 1;
            itspikes(iSpike) = ij; %it is the index of the time instance where we are
            iSpike = iSpike+1;
        end
    %After spike condition
    else
        u_s = c;
        u(ij) = u_s + dt*(alfa*(u_s^2)+ beta*u_s + gamma - w(ij-1) + I(ij-1));

        w(ij) = w(ij-1) + dt*(a*(b*u(ij) - w(ij-1)));
        spike = 0;
    end % if spike
    
end % for


%%% PLOTTING (optional)
    if flagPlot
       %Plotting current under membrane potential response
        I_i = I - 90;

        %Plotting Results

        %Membrane Potential Response
        figure(1)
        hold on
        plot(u);    %Membrane Potential
        hold on; 
        plot(I_i);  %Input Current
        xlabel('Time [ms]');
        ylabel('Membrane Potential [mV]');
        title('Tonic Spiking Membrane Potential Response');
        legend('Membrane Potential', 'Input Current');
    end

end % function