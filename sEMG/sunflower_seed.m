% Let's create fibers and assigned them to motoneurons
% SUNFLOWER SEED ARRANGEMENT
% adapted from: https://it.mathworks.com/matlabcentral/fileexchange/10796-model-a-sunflower-with-the-golden-ratio?focused=6011394&tab=example

function [x,y] = sunflower_seed(nf,xc,yc,r_mn,rf)
%   nf     : number of fibers of this motoneuron
%   xc, yc : center of the motoneuron territory wrt center of the muscle
%   r_mn   : radius of the MN territory
%   rf     : radius of a fiber


    wrt_muscleCenter = 1; % We want the coord wrt the muscle center always
  
    if nf == 1
        x = 0; y = 0; %for a single fiber, we put it in the middle
    else 
        phi_aurea = (sqrt(5)-1)/2;
        rho = (0:nf-1).^phi_aurea;
        rho = (r_mn-rf).*rho./max(rho); %normalized (avoid putting fibers right at the edge)
        theta = (0:nf-1)*2*pi*phi_aurea;

        [x,y]= pol2cart(theta,rho); % position wrt center of MN territory
    end
    
    if wrt_muscleCenter
        x = x + xc;
        y = y + yc;
    end
end