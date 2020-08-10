% Create_Spike_Templates

% Output:
%   - muap_pool{i_mn}
%   - potFib_pool{i_mn}
%   - h2l_muap_peak_idx: to know which one has a higher peak in one of the waveforms
%   from the AP (to check things): from high to low
%   - max_muap_peak: for plotting reasons

tic
for i_mn = 1:mnp
    Create_Spike_Templates_MN_old
    potFib_pool1{i_mn} = potFib{1}'; % 1st electrode
    muap_pool1{i_mn} = muap{1}'; % 1st electrode
    aux = potFib{1};
    potFib_max(i_mn) = max(aux(:));
    aux2 = muap{1};
    muap_max(i_mn) = max(aux2(:));
end
toc

[out,indx] = sort(muap_max);
out = fliplr(out); % to get higher first
h2l_muap_peak_idx = fliplr(indx);
max_muap_peak = out(1);

[out,indx] = sort(potFib_max);
out = fliplr(out); % to get higher first
h2l_potFib_peak_idx = fliplr(indx);
max_potFib_peak = out(1);

clear out muap_max muap aux aux2