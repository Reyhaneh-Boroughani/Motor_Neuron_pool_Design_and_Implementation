% defining_twitch_pool

% Parameters
%  - RP: range of peak amplitudes
%  - RT: range of contraction times
%  - mnp: number of motoneurons in the pool

% Output
%  - P: peaks of twitch forces (first smaller and first recruited)
%  - Ptotal: total peak twitches;
%  - Tc: contraction time (first smaller and first recruited)


% motor-unit twitch: defining the isometric force-time curve
b = (1/mnp)*log(RP); % range of peak amplitudes
c = log(RP)/log(RT); %range of contraction times

P = exp(b*(1:mnp))'; %peaks
Ptotal = sum(P); %total peak twitches
Tc = TL.*(1./P).^(1/c); %longest / contraction time

clear b c