function [FR,label_mat] = selecting_current_timewindow(mn_feat,w_first, w_last,Ntrials, Nexc)

% everything in a single matrix
    mnp = 100;
    
    label = ["strong","weak","fast","slow"];
    
    FR_All = zeros(5*5,mnp,2);
    FR = {};
    label_mat={};

    for ilabel = 1:4
        ik = 1;
        for itrial = 1:Ntrials(ilabel)
            for iexc = 1:Nexc(ilabel)
                FR_aux = mn_feat{ilabel}{1}{itrial,iexc};
                FR{ilabel}(ik,:,:) =[mean(FR_aux(1:w_last,:),1); (FR_aux(w_last,:)-FR_aux(w_first,:))]';
                ik = ik+1;
            end
        end
        label_mat{ilabel} = repmat([label(ilabel)],Ntrials(ilabel)*Nexc(ilabel),1);
    end
end

