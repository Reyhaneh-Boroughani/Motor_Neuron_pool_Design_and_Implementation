%% Neural Prostheses %%
% M.Sc. in Bionics Engineering 
% 
% Final Project
% A.Y. 2019/2020
% Second Semester

% Project:
% Design and implementation of a model of motor neuron pools performing 
% movements to test online decoding algorithms based on intrafascicular 
% (or EMG) recordings


% Model Description:

%The model consist in three parts:

%   1) Motoneuron Pool
%       A Motoneuron pool simulating the activation during the movement
%       intention
    
%   2) Recording device (EMG)
%       A model of the interface between the motoneuron pool and the 
%       recording device  
         
%   3) Decoding
%       Runs the complete simulation and decode the obtained signal to
%       verify the model function


%%%%%%%%%%%%%%
% Other files:
%%%%%%%%%%%%%%

% Simulation_Parameters
% Input_Current
% Tonic_Spiking
% Class_1_Excitable
% Fuglevand
% Izhikevich


%% Motoneuron Pool Model %%

% Description:
% Consist in a hypothetical motoneuron pool model to simulate how
% populations of motoneuron models may be organized to produce muscle force
% starting from the movement intent and resulting in a spike train output.

% Based on the models proposed on Fuglevand et al. 1993, 
% and Abdelghani et al. 2014  

% Clear Environment
% close all;
% clear all;
% clc


%% Motor Intent %%

% Motor Intent is the voluntary intention of a person that leads to
% activation of the neuromotor system

% Defined as Motor_Intent it varies from 0 to 100% 
% Four types of Input Current:
% input_type = 'unitstep';
% input_type = 'ramp';
% input_type = 'ramp_hold';
% input_type = 'trapezoid';

%% Excitatory Drive (E) %%
% is the Motor_Intent once converted to a signal adequated for each motor 
% unit input

% In this case we are assuming the Excitatory signal is received at the
% same level in all motoneurons => G = 1;


%% Motoneuron Unit Model %%

% Each Motoneuron Unit has its own:
%   1. Recruitment Threshold Level
%   2. Rate Coding Model

%% Initialization
%adding paths
addpath('./sEMG');
addpath('./Motoneurons');
addpath('./Force');

% initialization
Defining_Parameters
Get_Motoneurons_Properties
Create_Spike_Templates
E_amp = 10; duration = 5000; input_type = 'unitstep';

% Excitation
E= E_amp*Input_Current(input_type,duration); %%stires different E_aux for further simulations, right now manual lables!!

Nt = size(E,2);
t = 0:dt:dt*(Nt-1);

% GO!
Firing_Recording_sEMG

