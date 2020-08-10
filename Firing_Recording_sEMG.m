%% Firing, recording and EMG (with no initializations)
% Initialization of variables
SpikeTrain = zeros(mnp,Nt);
%% Firing
for ip = 1:totalnumpools %index refering to the pool
np = Nn(ip); %neurons in this pool

Defining_RTE_FR_pool
Defining_Twitch_Pool

%RTE = zeros(mnp,1);

% PER NEURON
Fp = zeros(np,Nt);
FR_MN = zeros(1,np);
% figure(1)
tic
%for each E selected from E{numtrial,numE} (numtrial=10, numE=5)

I_noise = var_I*randn(np,size(E,2)); 
fnoise_cut = 150; fs = 1/(dt*1E-3);%Hz
I_noise = lowpass(I_noise,fnoise_cut,fs); 

                % EACH NEURON
                for in = 1:np %we have to do each neuron separately
                %     in
                    % INITIALIZATION 
                    cond = (E >= RTE(in));
                    it = find(cond(:),1,'first'); %find the first time instance where the condition is true (excited neuron);
                    if isempty(it) %if this neuron is not excited, neither will be the following, as RTE increases
                       break % we can exit the loop
                    end


                    % Choose wisely, young padawan
                    %Fuglevand %Result: tspikes

                    Run_Izhikevich %Result: tspikes



                    % Saving the spikes, generating the time of each spike and counting the total number of spikes    
                    
                    itspikesP{ip,in} = itspikes;    
                    tspikesn = t(itspikes); tspikes{ip,in} = tspikesn;  %time instances
                    Nspikesn = size(itspikes,2); Nspikes{ip,in} = Nspikesn; %number of spikes
                    spikeTrain_mn = zeros(Nt,1);
                    spikeTrain_mn(itspikes) = 1;


                    % TWITCH: single neuron, various spikes (IN: tspikes,Nspikes)
                    if ISI_exists
                        Get_Twitches; %Fn: sum of each twitch for this neuron   
                        Fp(in,:) = Fn; %Total force of this neuron
                    end

                    % We're saving the spike train (boolean vector of 0 and 1)
                    SpikeTrain(in,:) = spikeTrain_mn(:);

                    %storing FR
%                     aux = itspikes(2:end)-itspikes(1:end-1);
%                     FR_all = 1./(aux*1E-4);
%                     if size(itspikes,2) > 20
%                         FR_MN(in) = mean(FR_all(end-10:end));
%                     else
%                         FR_MN(in) = FR_all(end);
%                     end    
                end

toc

%figure(1)
%plot(t,Fp')

% figure(10)
% plot(t,SpikeTrain')
% title('SpikeTrain')
end

% figure(15)
% plot(t,E)
% title('Excitatory signal')

% % Calculate emg
muap_aux = cell2mat(muap_pool1)';
y = zeros(mnp, Nt+size(muap_aux(1,:),2)-1);
for ij = 1:mnp
    y(ij,:) = conv(muap_aux(ij,:),SpikeTrain(ij,:));
end
emg = sum(y);
clear y