% load data2classify
%% filtering
rawEMG=data2classify.emg;
samplingFreq=10000; %%1kHz
lowFcutoff=20; %%Typical values for the low frequency cutoff are 5 to 20 Hz.
hiFcutoff=450; %%Typical values are 200 Hz – 1 kHz. 
filtEMG = filterEMG(rawEMG, samplingFreq, lowFcutoff, hiFcutoff);
%% compare 
% figure(1);clf;
% hold on
% plot(rawEMG(1,:),'r') %the first sample=weak e_amp=5
% plot(filtEMG(1,:),'b')
% legend('rawEMG','filteredEMG')
%% getEMGfeaturesAllData(filtEMG, windowsize, stepsize)
[EMGobj] = getEMGfeaturesTD(filtEMG);
X=[EMGobj.VAR, EMGobj.MAV, EMGobj.WL, EMGobj.ZC, EMGobj.SSC];
%% %% lables(targets of classification)
Y=data2classify.lable; 
classes = unique(Y);  %0 weak, 1 strong, 2 slow, 3 fast
%% devide to train and test randomly
rand_num=randperm(100);
X_train = X(rand_num(1:round(0.8*length(rand_num))),:);
Y_train = Y(rand_num(1:round(0.8*length(rand_num))),:);

X_test = X(rand_num(round(0.8*length(rand_num))+1:end),:);
Y_test = Y(rand_num(round(0.8*length(rand_num))+1:end),:);
%% SVM
[predict1] = classifySVMoffline(X_train', Y_train', X_test', Y_test');
%% Accuracy
test_accuracy = sum(predict1' == Y_test)/length(Y_test)*100;
%% Plot of the confusion matrices 
[Cmat,DA]= confusion_matrix(predict1',Y_test,{'weak','strong','slow','fast'});
%% %number of missclassified objects
% ACTUAL=Y_test';
% PREDICTED=predict1;
%     numClasses = max([ACTUAL,PREDICTED]);
%     classvec = unique([ACTUAL,PREDICTED]);
%     globalErrors = 0;
%     for i = 1:length(ACTUAL)
%         if PREDICTED(i) ~= ACTUAL(i)
%             globalErrors = globalErrors+1; %number of missclassified objects
%         end
%     end    
%     classwiseStats.globalAccuracy = 1 - globalErrors/length(ACTUAL);  