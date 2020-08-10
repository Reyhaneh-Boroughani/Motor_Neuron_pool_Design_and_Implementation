% Create_Spike_Templates_MN_old || no decaying
% (per motoneuron) 

% VARIABLES
% Parameters (previously defined) used
%  - bss            : distance btw current source and sink
%  - Conductivity
%       - cond_z : along the fiber direction
%       - cond_r : transversal wrt fiber direction
%  - I              : current
%  - pos_el{1}      : position first electrode
%  - pos_el{2}      : position second electrode
%  - dt             : time resolution
%  - 

% Requirements (previously executed scripts apart from parameters)
%  - Get_Motoneurons_Properties


% Parameters (defined/constructed) here
%  For each MOTONEURON (i_mn)
%  --- reminder: mn_definitions: [x y r_mn A_mn nf_mn velprop_mn] ---
%       - xc,yc          : center of the motoneuron (wrt muscle center)
%       - r_mn           : radius of the MN territory
%       - nf             : # fibers
%       - velprop        : velocity of propagation of the wave
%  - zf                  : position of each fiber endplate (we consider it fix for now)

xc = mn_definitions(i_mn,1); yc = mn_definitions(i_mn,2);
nf = mn_definitions(i_mn,5); r_mn = mn_definitions(i_mn,3);
velprop = mn_definitions(i_mn,6); 

zf = zfconst*ones(1,nf); % For now the end-plate is always at the same place

%       - xf,yf          : position of fibers wrt center of the muscle (created here) 
%       - pos_f(xf,yf,zf) : position of the fibers in general (wrt center of the muscle)

[xf,yf] = sunflower_seed(nf,xc,yc,r_mn,rf); % to get fibers distribution within the MN territory
pos_f = [xf',yf',zf']; 

% Outputs
%  - potFib{1,2}     : matrix containing the AP for each fiber in the MN
%                    related to electrode 1/2
%  - muap{1,2}        : matrix containing the MUAP (sum of AP for each fiber)

% PRINCIPLES USED
% We approximate that the current moving by two dipoles moving in opposite directions 


%% Algorithm

% To construct the spike template
tTempl = 0:dt:TfTempl  ; NtTempl = size(tTempl,2);

% MUAP extra parameters
alpha_cond = cond_z/cond_r; %ratio of conductivities
kpot = (I/4*pi*cond_r); %constant associated to the potential 1/4pi\sigma_r



for i_el = 1 % repeat for each electrode
    
    % LOCATIONS
    % Using as origin of the system of reference the electrode position
    pos_fel = pos_f - repmat(pos_el{i_el},nf,1); %each row is a fiber

    z_fe = pos_fel(:,3); %distance (along z axis) from the electrode to the end-plate
    pos_feT_2 = pos_fel(:,1).^2+pos_fel(:,2).^2; %squared distance on the Transversal plane to the fiber (x,y)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % MUAP MOVING TOWARDS THE ELECTRODE
    %each row is a fiber, columns are instants of time
    z1 = velprop*(tTempl)+z_fe; %the muap moves along the fiber
    r1 = sqrt(pos_feT_2*alpha_cond + z1.^2); % distance to current source (I+)
    r2 = sqrt(pos_feT_2*alpha_cond + (z1+bss).^2); % distance to current sink (I-)

    % MUAP MOVING AWAY FROM ELECTRODE
    z3 = -velprop*(tTempl)+z_fe;
    r3 = sqrt(pos_feT_2*alpha_cond + z3.^2); % distance to current source (I+)
    r4 = sqrt(pos_feT_2*alpha_cond + (z3-bss).^2); % distance to current sink (I-)

    % MUAP
    phi_fib =  I.*kpot.*( 1./r1-1./r2 - 1./r3 + 1./r4);
    potFib{i_el} = phi_fib;
    muap{i_el} = sum(phi_fib,1);
    clear phi_fib
end


%% DECAYING
% forward = ones(1,NtTempl); backward = ones(1,NtTempl);
% %exponential decay
% Tdecay = 0.06; L = 5;
% forward(z1 >= L/2) = exp((1:dt:)./Tdecay);
% backward(z3-b <= -L/2) = exp(-t./Tdecay);
% 
% phi =  I.*kpot.*(forward.*( 1./r1-1./r2) - backward.*(1./r3 - 1./r4));
% figure(2)
% plot(phi');

%% Cleaning up

clear xc yc nf r_mn velprop zf pos_f NtTempl alpha_cond kpot pos_fel zef pos_ef2 z1 r1 r2 z3 r3 r4