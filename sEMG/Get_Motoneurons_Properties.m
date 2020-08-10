% Get_Motoneurons_Properties

% VARIABLES
% Parameters (previously defined) used
%  - Rm             : radius of the muscle
%  - nft            : # total fibers - it's gonna be UPDATED
%  - density_fibers : in the muscle
%  - overlap        : can motoneurons territories overlap? (1: total overlapping | 0: no overlapping);
%  - mnp            : # motoneurons (motounits) in this pool

% Requirements (previously executed scripts apart from parameters)
%  - Defining_Twitch_Pool

% Outputs
%  - mn_definitions: [x y r_mn A_mn nf_mn velprop_mn] (smaller mn & first recruited first)
%       1. x y        : center of each motoneuron
%       2. nf_mn      : # fibers per motoneuron 
%       3. A_mn       : area of each motoneuron territory
%       4. r_mn       : radius of each motoneuron territory
%       5. velprop_mn : Velocity of propagation, different for each MN
%  - *UPDATED* nft

% PRINCIPLES USED
% Motoneurons ennerve a finite territory, called motoneuron territory.
% Here, the territory is assumed as circular and with size is proportional 
% to the peak force of each motoneuron.
%
% Each MN territory is randomly assigned, avoiding (complete) overlapping
% and within the limits of the muscle.

% Some new parameters
nf_mn = round((nft/Ptotal)*P); %#fibers of each motoneuron;
sumnf = sum(nf_mn);
if sumnf ~= nft % checking the total of fibers is the same after rounding and updating the value
    msg = 'Rounding slightly affected the total number of fibers.\n  Initially, %d fibers were defined\n  Now, there are %d.\nThe corresponding variable (nft) has been updated.';
    warning(msg, nft, sumnf)
    nft = sumnf;
    clear msg
end
clear sumnf
    

A_mn = nf_mn/density_fibers;
r_mn = sqrt(A_mn/pi);
r_mn = flipud(r_mn); % we want to locate first the larger territories - it makes our lives easier
Raprox = sqrt(sum(A_mn)/pi);
msg = 'The minimum radius to fit everything would be %d mm';
warning(msg, Raprox)
% bigger first
%%

%clear existing_circles
existing_circles = zeros(mnp,3); %keep new circles (x,y,r)
ik = 1; max_iter = 1000;
ij = 1;
while ij <= mnp & ik <= max_iter
    r_new = r_mn(ij);
    pos_new= (Rm-r_new)*(1-2*rand(1,2)); %pos = x,y
    % by substracting r_new, we avoid considering points that when we draw 
    % the circle would overlap with the border don't want

    cond_inside = sqrt(pos_new(1)^2+pos_new(2)^2) < (Rm-r_new);
    
    while ~cond_inside %first let's make sure we're inside the muscle
        pos_new= Rm*(1-2*rand(1,2)); %pos = x,y
        cond_inside = sqrt(pos_new(1)^2+pos_new(2)^2) < (Rm-r_new);
    end
    
    if check_conditions(pos_new,r_new,existing_circles,overlap) %add to the list if it exists
        existing_circles(ij,:) = [pos_new,r_new];
        
        ij = ij+1;
    end
    
    if ik == max_iter
        msg = 'Maximum number of iterations reached: %d \n - Motoneurons that could be defined: %d \n - You can try increasing the overlap (now %.2d)';
        error(msg,max_iter, ij-1, overlap)
        clear msg
    end
    
    ik = ik+1;
end

%% Ploting
if flagMNTerritories
gcf = figure(1);
viscircles([existing_circles(:,1:2)], existing_circles(:,3));
viscircles([0,0],Rm,'Color','k');
axis([-Rm Rm -Rm Rm]);
pbaspect([1 1 1]);
gcf.Resize = 'off'
title('Motoneurons territories')
hold on
end

%% Cleaning up
velprop = velprop_min + (Tc-min(Tc))./(max(Tc)-min(Tc))*(velprop_max-velprop_min); % adding the velocity of propagation of each motoneuron
mn_definitions = [flipud(existing_circles), A_mn, nf_mn, velprop]; % mn territories defined by its center and the radius and properties
clear ij ik max_iter r_new pos_new cond_inside existing_circles A_mn r_mn R_aprox

%% Oh, hi! This is an auxiliary function. Don't mind me!
function [cond] = check_conditions(pos_new,r_new,existing_circles,overlap)
    % pos_new, r_new: New motoneuron being added
    % existing_circles: contains all the previously created circles
    % overlap: to allow some degree of overlapping
    
    cond = true; %if nothing, you can add it
    first_zero = find(existing_circles(:,3) == 0,1); %let's only check for motoneurons existing, not the predefault 0
    
    if isempty(first_zero) %we shouldn't really have this case
        L = size(existing_circles,1);
        msg = 'Hi! Something weird is happening. You are checking to put a new motoneuron, but all of them are already located, because the matrix is full.';
        warning(msg);
    else
        L = first_zero-1; %first zero is already out
    end
    
    for ik = 1:L %we only check
        pos_existing = existing_circles(ik,1:2); r_existing = existing_circles(ik,3);
        cond = norm(pos_new-pos_existing) > (1-overlap)*(r_new + r_existing);
        if ~cond
            break
        end

    end        
end

