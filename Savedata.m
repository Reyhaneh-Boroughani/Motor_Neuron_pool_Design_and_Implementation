%% WEAK
numE=5;                  %how many E do you need between [lower_limit, upper_limit], this is fixed!
numtrial=5;              %how many trials for each specific E, this is fixed!
%
duration=2500;           %this is fixed! (5s)
lower_limit=5;           %change this according to the lable you have!
upper_limit=15;          %change this according to the lable you have!
            %how many trials for each specific E, this is fixed!
input_type="unitstep";   %if lable=["Weak","Strong"] then "unitstep", if lable=["fast","slow"] then "ramp"
lable="weak";            %change this ["Weak","Strong","Fast","Slow"]

%load Data\potFib_pool1.mat    %we only have one configuration of motoneuron inside the muscle, so load everytime the same potFib_pool1 and muap_pool1
load Data\muap_pool1.mat

[E_struct_weak,SpikeTrain_struct_weak,Fp_struct_weak,emg_struct_weak] = Chose_Excitation(duration,lower_limit,upper_limit,numE,numtrial,input_type,lable,muap_pool1);

% SAVING DATA
% % put the filename according to the file and lable(e.g E_struct_weak)
save("E_struct_weak", "E_struct_weak") 
save("SpikeTrain_struct_weak", "SpikeTrain_struct_weak")
save("Fp_struct_weak", "Fp_struct_weak")
save("emg_struct_weak", "emg_struct_weak")

%% ANOTHER: STRONG
clear all
duration=2500;           %this is fixed! (5s)
lower_limit=25;           %change this according to the lable you have!
upper_limit=35;          %change this according to the lable you have!
numE=5;                  %how many E do you need between [lower_limit, upper_limit], this is fixed!
numtrial=5;              %how many trials for each specific E, this is fixed!
input_type="unitstep";   %if lable=["Weak","Strong"] then "unitstep", if lable=["fast","slow"] then "ramp"
lable="strong";            %change this ["Weak","Strong","Fast","Slow"]

%load Data\potFib_pool1.mat    %we only have one configuration of motoneuron inside the muscle, so load everytime the same potFib_pool1 and muap_pool1
load Data\muap_pool1.mat

[E_struct_strong,SpikeTrain_struct_strong,Fp_struct_strong,emg_struct_strong] = Chose_Excitation(duration,lower_limit,upper_limit,numE,numtrial,input_type,lable,muap_pool1);

display('we are saving')
% SAVING DATA
% % put the filename according to the file and lable(e.g E_struct_weak)
save("E_struct_strong", "E_struct_strong") 
save("SpikeTrain_struct_strong", "SpikeTrain_struct_strong")
save("Fp_struct_strong", "Fp_struct_strong")
save("emg_struct_strong", "emg_struct_strong")
display('!!! strong is done !!!')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ANOTHER: FAST
clear all
duration=2500;           %this is fixed! (5s)
lower_limit=35;           %change this according to the lable you have!
upper_limit=35;          %change this according to the lable you have!
numE=1;                  %how many E do you need between [lower_limit, upper_limit], this is fixed!
numtrial=25;              %how many trials for each specific E, this is fixed!
input_type="ramp_hold";   %if lable=["Weak","Strong"] then "unitstep", if lable=["fast","slow"] then "ramp"
lable="fast";            %change this ["Weak","Strong","Fast","Slow"]

%load Data\potFib_pool1.mat    %we only have one configuration of motoneuron inside the muscle, so load everytime the same potFib_pool1 and muap_pool1
load Data\muap_pool1.mat

[E_struct_fast,SpikeTrain_struct_fast,Fp_struct_fast,emg_struct_fast] = Chose_Excitation(duration,lower_limit,upper_limit,numE,numtrial,input_type,lable,muap_pool1);

display("we are saving")
% SAVING DATA
% % put the filename according to the file and lable(e.g E_struct_weak)
save("E_struct_fast", "E_struct_fast") 
save("SpikeTrain_struct_fast", "SpikeTrain_struct_fast")
save("Fp_struct_fast", "Fp_struct_fast")
save("emg_struct_fast", "emg_struct_fast")

display('!!! fast is done !!!')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ANOTHER: SLOW
clear all
duration=2500;           %this is fixed! (5s)
lower_limit=35;           %change this according to the lable you have!
upper_limit=35;          %change this according to the lable you have!
numE=1;                  %how many E do you need between [lower_limit, upper_limit], this is fixed!
numtrial=25;              %how many trials for each specific E, this is fixed!
input_type="ramp";   %if lable=["Weak","Strong"] then "unitstep", if lable=["fast","slow"] then "ramp"
lable="slow";            %change this ["Weak","Strong","Fast","Slow"]

%load Data\potFib_pool1.mat    %we only have one configuration of motoneuron inside the muscle, so load everytime the same potFib_pool1 and muap_pool1
load Data\muap_pool1.mat

[E_struct_slow,SpikeTrain_struct_slow,Fp_struct_slow,emg_struct_slow] = Chose_Excitation(duration,lower_limit,upper_limit,numE,numtrial,input_type,lable,muap_pool1);

display('we are saving')
% SAVING DATA
% % put the filename according to the file and lable(e.g E_struct_weak)
save("E_struct_slow", "E_struct_slow") 
save("SpikeTrain_struct_slow", "SpikeTrain_struct_slow")
save("Fp_struct_slow", "Fp_struct_slow")
save("emg_struct_slow", "emg_struct_slow")
display('!!! slow is done !!!')

%% SLOW AND WEAK
clear all
duration=2000;           %this is fixed! (5s)
lower_limit=35;           %change this according to the lable you have!
upper_limit=35;          %change this according to the lable you have!
numE=1;                  %how many E do you need between [lower_limit, upper_limit], this is fixed!
numtrial=25;              %how many trials for each specific E, this is fixed!
input_type="unitstep_ramp"; 
init_val = 0; end_val = 0.5; st = 5000;
lable="SlowWeak";            %change this ["Weak","Strong","Fast","Slow"]

%load Data\potFib_pool1.mat    %we only have one configuration of motoneuron inside the muscle, so load everytime the same potFib_pool1 and muap_pool1
load Data\muap_pool1.mat

[E_struct_SlowWeak,SpikeTrain_struct_SlowWeak,Fp_struct_SlowWeak,emg_struct_SlowWeak] = Chose_Excitation(duration,lower_limit,upper_limit,numE,numtrial,input_type,lable,muap_pool1,init_val,end_val,st);

display('we are saving')
% SAVING DATA
% % put the filename according to the file and lable(e.g E_struct_weak)
save("E_struct_SlowWeak", "E_struct_SlowWeak") 
save("SpikeTrain_struct_SlowWeak", "SpikeTrain_struct_SlowWeak")
save("Fp_struct_SlowWeak", "Fp_struct_SlowWeak")
save("emg_struct_SlowWeak", "emg_struct_SlowWeak")
display('!!! slow&weak is done !!!')

%% SLOW AND STRONG
clear all
duration=2000;           %this is fixed! (5s)
lower_limit=35;           %change this according to the lable you have!
upper_limit=35;          %change this according to the lable you have!
numE=1;                  %how many E do you need between [lower_limit, upper_limit], this is fixed!
numtrial=25;              %how many trials for each specific E, this is fixed!
input_type="unitstep_ramp"; 
init_val = 0.5; end_val = 1; st = 5000;
lable="SlowStrong";            %change this ["Weak","Strong","Fast","Slow"]

%load Data\potFib_pool1.mat    %we only have one configuration of motoneuron inside the muscle, so load everytime the same potFib_pool1 and muap_pool1
load Data\muap_pool1.mat

[E_struct_SlowStrong,SpikeTrain_struct_SlowStrong,Fp_struct_SlowStrong,emg_struct_SlowStrong] = Chose_Excitation(duration,lower_limit,upper_limit,numE,numtrial,input_type,lable,muap_pool1,init_val,end_val,st);

display('we are saving')
% SAVING DATA
% % put the filename according to the file and lable(e.g E_struct_weak)
save("E_struct_SlowStrong", "E_struct_SlowStrong") 
save("SpikeTrain_struct_SlowStrong", "SpikeTrain_struct_SlowStrong")
save("Fp_struct_SlowStrong", "Fp_struct_SlowStrong")
save("emg_struct_SlowStrong", "emg_struct_SlowStrong")
display('!!! slow&strong is done !!!')

%% FAST AND WEAK
clear all
duration=2000;           %this is fixed! (5s)
lower_limit=35;           %change this according to the lable you have!
upper_limit=35;          %change this according to the lable you have!
numE=1;                  %how many E do you need between [lower_limit, upper_limit], this is fixed!
numtrial=25;              %how many trials for each specific E, this is fixed!
input_type="unitstep_ramp_hold"; 
init_val = 0; end_val = 0.5; st = 5000;
lable="FastWeak";            %change this ["Weak","Strong","Fast","Slow"]

%load Data\potFib_pool1.mat    %we only have one configuration of motoneuron inside the muscle, so load everytime the same potFib_pool1 and muap_pool1
load Data\muap_pool1.mat

[E_struct_FastWeak,SpikeTrain_struct_FastWeak,Fp_struct_FastWeak,emg_struct_FastWeak] = Chose_Excitation(duration,lower_limit,upper_limit,numE,numtrial,input_type,lable,muap_pool1,init_val,end_val,st);

display('we are saving')
% SAVING DATA
% % put the filename according to the file and lable(e.g E_struct_weak)
save("E_struct_FastWeak", "E_struct_FastWeak") 
save("SpikeTrain_struct_FastWeak", "SpikeTrain_struct_FastWeak")
save("Fp_struct_FastWeak", "Fp_struct_FastWeak")
save("emg_struct_FastWeak", "emg_struct_FastWeak")
display('!!! fast&weak is done !!!')

%% FAST AND STRONG
clear all
duration=2000;           %this is fixed! (5s)
lower_limit=35;           %change this according to the lable you have!
upper_limit=35;          %change this according to the lable you have!
numE=1;                  %how many E do you need between [lower_limit, upper_limit], this is fixed!
numtrial=25;              %how many trials for each specific E, this is fixed!
input_type="unitstep_ramp_hold"; 
init_val = 0.5; end_val = 1; st = 5000;
lable="FastStrong";            %change this ["Weak","Strong","Fast","Slow"]

%load Data\potFib_pool1.mat    %we only have one configuration of motoneuron inside the muscle, so load everytime the same potFib_pool1 and muap_pool1
load Data\muap_pool1.mat

[E_struct_FastStrong,SpikeTrain_struct_FastStrong,Fp_struct_FastStrong,emg_struct_FastStrong] = Chose_Excitation(duration,lower_limit,upper_limit,numE,numtrial,input_type,lable,muap_pool1,init_val,end_val,st);

display('we are saving')
% SAVING DATA
% % put the filename according to the file and lable(e.g E_struct_weak)
save("E_struct_FastStrong", "E_struct_FastStrong") 
save("SpikeTrain_struct_FastStrong", "SpikeTrain_struct_FastStrong")
save("Fp_struct_FastStrong", "Fp_struct_FastStrong")
save("emg_struct_FastStrong", "emg_struct_FastStrong")
display('!!! fast&strong is done !!!')