% Time_Goes_By_And_Neurons_Fire
 
% initialization
%ik = 1; %initialization for the while loop
itspikes = []; %indexes of spikes
%ISI = [];


% TIME GOES BY: evolve in time
    while it  < Nt
        
        %if E is no longer greater than RTE
        %BUT WAIT? WHAT IF IT'S TRYING TO TRICK US? WHAT IF THEN IT IS
        %GREATER THAN RTE AGAIN?
        if ~cond(it)
            % we check if it happens again in order to restart
            it = it + find(cond(it+1:end),1,'first'); %find the NEXT first time instance where the condition is true (excited neuron);
            if isempty(it) %the neuron is no longer excited,
               break % we can exit the loop
            end
        end
        %SOLVED
        
        Get_Spikes_Indexes
        
    end