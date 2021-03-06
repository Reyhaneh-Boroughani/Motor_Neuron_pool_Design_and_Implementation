%% select the motoneurons
Ntrials = [5, 5, 25, 25]; Nexc = [5,5,1,1];
mnp = 100;  
Lw = 1000; %5500 figure best results for whole signal(1) %not in ms, but in 0.1ms steps

[mn_feat] = finding_FR_struct(Lw,Ntrials, Nexc);
    
%% 
w_last = 24; w_first = 6;
Nmn_selvec = [1:20];    
Nrep = 100;
test_accuracy_vec = zeros(length(Nmn_selvec),Nrep);

for isel = 1:length(Nmn_selvec);
    Nmn_sel = Nmn_selvec(isel)
    tic
    for ik = 1:Nrep %this loop is for the slop at the same time instance
        %first all FR and then all FR_slopes
        mn_rand = randperm(mnp);
        mn_selected = mn_rand(1:Nmn_sel);

            [FR,label_mat] = selecting_current_timewindow(mn_feat,w_first, w_last,Ntrials, Nexc);



            [FR_selected, label_selected] = selecting_MN_for_FR_features(mn_selected,FR, label_mat,Ntrials, Nexc);


            FR_selected = [];
            label_selected = [];

            for ilabel = 1:4
                FR_selected = [FR_selected; reshape(FR{ilabel}(:,mn_selected,:),Ntrials(ilabel)*Nexc(ilabel),2*length(mn_selected))];
                label_selected = [label_selected; label_mat{ilabel}];
            end

            %training with a couple of forces only for each label
            ind_train = [1 25 26 50 51 75 76 100];
            ind_test = setdiff(1:Ntrials(ilabel)*Nexc(ilabel)*4,ind_train);
            ind_test = ind_test(randperm(length(ind_test))); %let's disorder them

            FR_train = FR_selected(ind_train,:);
            Y_train = label_selected(ind_train,:);

            FR_test = FR_selected(ind_test,:);
            Y_test = label_selected(ind_test,:);


            % SVM
            [predict1] = classifySVMoffline(FR_train', Y_train', FR_test', Y_test');
            % Accuracy
            test_accuracy = sum(predict1' == Y_test)/length(Y_test)*100;
            % Plot of the confusion matrices 
            %[Cmat,DA]= confusion_matrix(predict1',Y_test,{'weak','strong','slow','fast'});

            test_accuracy_vec(isel,ik)=test_accuracy;
            mn_selected_vec{isel,ik} = mn_selected;
    end
    toc
end

%%
mean_accuracy = mean(test_accuracy_vec,2);
Q1 = quantile(test_accuracy_vec',0.25)';
Q2 = quantile(test_accuracy_vec',0.75)';

figure(5)
hold on
errorbar(Nmn_selvec,mean_accuracy(:),(Q1-mean_accuracy),(Q2-mean_accuracy))

axis([0 11 0 100])
xlabel('Motoneuron')
ylabel('Accuracy')

%%
% min_accuracy = min(test_accuracy_vec,[],3);
% figure(2)
% for isel = 1:length(Nmn_selvec);
%     plot(min_accuracy(isel,:))
%     hold on
% end
% hold off
% axis([1 10 0 100])
% %legend
