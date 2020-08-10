%%%%%%%%%%%%%%%
% 1. Run_Izichevich
%%%%%%%%%%%%%%%
fnoise_cut = 150; %(Hz)
fs = 1/(dt*1E-3); %sampling freq (Hz)
%I = 2.5*0.0345*(E-RTE(in)) + 1;
coeff = 0.7;
I = coeff*(E-RTE(in)) + 1;
I = (1+I_noise(in,:)).*I;
I(E < RTE(in)) = 0;
I(E > E_PFR(in)) =  coeff*(E_PFR(in)-RTE(in)) + 1;

itspikes = Izhikevich(type,I,dt, RandNoiseIzh, flagIzh);

ISI_vec = zeros(size(itspikes));

if size(itspikes,2)>1
    ISI_exists = 1;
    ISI_vec(1:end-1) = itspikes(2:end)-itspikes(1:end-1);
    ISI_vec(end) = ISI_vec(end-1);
    ISI_vec = ISI_vec*dt;
else
    ISI_exists = 0;
end
% OUTPUT: itspikes