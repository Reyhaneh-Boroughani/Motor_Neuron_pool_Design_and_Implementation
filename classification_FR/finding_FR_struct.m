function [mn_feat] = finding_FR_struct(Lw,Ntrials, Nexc)

    
    %slow, fast, weak, strong
    %addpath('./Data')
    dt = 0.1; mnp = 100;
    label = ["strong","weak","fast","slow"];

    for ilabel = 1:4
        %name_file = strcat('Data-Maria-V02/SpikeTrain_struct_',label(ilabel));
        name_file = strcat('SpikeTrain_struct_',label(ilabel));
        SpikeTrain = struct2cell(load(name_file));
        SpikeTrain = SpikeTrain{1};
        %
        FRlb = {};
        FRlb_slope = {};
        
        if ilabel == 1 %in the beginning, we need to define a few more things
            Nt = size(SpikeTrain{1,1},2); %time instances
            t = 0:dt:(Nt-1)*dt; %in ms
            t = t/1000; %in sec
            Nw = ceil(Nt/Lw);
        end

        tic
        
        for iexc = 1:Nexc(ilabel)
            for itrial = 1:Ntrials(ilabel)
                st = SpikeTrain{itrial,iexc};
                FRn = zeros(Nw,mnp);
                for iw = 1:Nw
                    for in = 1:mnp
                        if iw == Nw
                            tspikes = t(logical(st(in,end-Lw+1:end)));
                        else
                            tspikes = t(logical(st(in,(iw-1)*Lw+1:iw*Lw-1)));
                        end
                        if size(tspikes,2) > 2
                            aux = 1./(tspikes(2:end)-tspikes(1:end-1));
                                %FRn(in) = mean(aux_filt(abs(zscore(aux_filt))<1)); %we filter using z-score
                            FRn(iw,in) = mean(aux);
                        end
                    end
                end
                FRlb{itrial,iexc} = FRn(:,:);
            end
            
        end
        
        
        
        
        toc
        mn_feat{ilabel} = {FRlb};
    end
            
end

