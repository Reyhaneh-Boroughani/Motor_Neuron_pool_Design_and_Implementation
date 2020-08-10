function [I] = Input_Current(input_type,total_duration, init_end, st)
% INPUT_CURRENT(input_type, total_duration, init_end)
%   Function to generate the input current according to its type, the total
%   duration and (possibly) the initial and end current value.
%   Instead of infinite slope, there's a 500 ms exponential to achieve the
%   initial value or to return from the final one to zero.
%   - input_type:   'unitstep', 'ramp', 'ramp_hold', unitstep_ramp',
%                   'unitstep_ramp_hold'
%   - total_duration (in ms)
%   - init_end:     [initial value, end value]
st=0; %the activation starts from st
dt=0.1;
%%parameters of sigmoid
a=1; %a is the hight of the sigmoid which is 1 now
b=0.15; %larger b steeper slope, but we don't want slope in this case, default=1, we change the slope with duration for ramp_hold
c=50; %dont change this!

% The magnitude of b controls the width of the transition area 
% c defines the center of the transition area.


x=linspace(0,100,5000);
%duration=duration/dt;
total_duration = total_duration/dt - st; %in instances (0.1 ms each)

switch input_type
    case 'unitstep'
        y=a./(1+exp(-b*(x-c))); %% sigmoid function
        duration = total_duration - 2*size(y,2);
        I=[zeros(1,st) y ones(1,duration) fliplr(y)];
        
    case 'ramp'
        y=a./(1+exp(-b*(x-c))); %% exponential function
        %Input current vector
        duration = total_duration-size(y,2);
        I=[zeros(1,st) (1/duration:1/duration:1)  fliplr(y)];
        
    case 'ramp_hold'
        y=a./(1+exp(-b*(x-c))); %% sigmoid function
        %Input current vector
        duration = total_duration - size(y,2);
        I=[zeros(1,st) (1/(duration/2):1/(duration/2):1) ones(1,(duration/2)) flip(y)];
          
    case 'unitstep_ramp'
        initial_value = init_end(1); end_value = init_end(2);
        y=a./(1+exp(-b*(x-c))); %% sigmoid function
        %Input current vector
        %end_value = 1-initial_value;
        aux_in = initial_value*y(1:4500); aux_end = end_value*y;
        duration = total_duration - 2*size(x,2);
        I = [zeros(1,st) aux_in linspace(aux_in(end),initial_value,500) linspace(initial_value,end_value,duration) fliplr(aux_end)];

    case 'unitstep_ramp_hold'
        %initial_value = 0.3;
        initial_value = init_end(1); end_value = init_end(2);
        y=a./(1+exp(-b*(x-c))); %% sigmoid function
        %Input current vector
        aux_in = initial_value*y(1:4500); aux_end = end_value*y;
        duration = total_duration - 2*size(x,2);
        I = [zeros(1,st) aux_in linspace(aux_in(end),initial_value,500) linspace(initial_value,end_value,duration/2) end_value*ones(1,duration/2) fliplr(aux_end)];

    otherwise
        warning('Input Current Type Not Selected')
end
end

% figure;
% str = ["unitstep","ramp","ramp_hold","unitstep_ramp","unitstep_ramp_hold"];
% num_str = length(str);   
% in_duration = 2000;
% for pp=1:1:num_str
%        
%     % To plot
%     subplot(num_str,1,pp);
%     
%     I= Input_Current(str(pp),in_duration);
%     plot(I);
%     title(['Input type ',num2str(str(pp))]);
%     % To appreciate the spikes amplitude
%     ylim([-0.5 1.5]);
%     
%     
%     % For loop counter     
%     pp=pp+1;
% 
% end % for