%%

muap_aux = cell2mat(muap_pool1)';
y = zeros(mnp, Nt+size(muap_aux(1,:),2)-1);
for ij = 1:mnp
    y(ij,:) = conv(muap_aux(ij,:),SpikeTrain(ij,:));
end

emg = sum(y);
figure(20)
plot(emg)