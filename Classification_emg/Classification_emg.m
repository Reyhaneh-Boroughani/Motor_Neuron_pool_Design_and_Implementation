clc
clear all
close all
%% 5trials, linspace(5,15,5) unitstep/ramp (weak,slow), linspace(25,35,5) unitstep/ramp (strong,fast), 
load emg_struct_weak.mat 
load emg_struct_strong.mat
load emg_struct_slow.mat
load emg_struct_fast.mat
%% 
% z=zeros(25, (length(emg_struct_strong{1,1})- length(emg_struct_fast{1,1}))/2);

emg_slow = cell2mat(emg_struct_slow);
emg_fast = cell2mat(emg_struct_fast);

emg_weak = cell2mat(reshape (emg_struct_weak, 25, 1));
emg_strong =cell2mat(reshape (emg_struct_strong, 25, 1));

lable=ones(100,1);
lable(1:25,1)=0;
lable(51:75,1)=2;
lable(76:100,1)=3;
Y=lable;
%% windowing, filtering, feature extracting
rawEMG=[emg_weak;emg_strong;emg_slow;emg_fast];
%% 
samplingFreq=10000; %%1kHz
lowFcutoff=20; %%Typical values for the low frequency cutoff are 5 to 20 Hz.
hiFcutoff=450; %%Typical values are 200 Hz – 1 kHz. 
%% 
test_accuracy=zeros(1,10);
dt=0.1;
window_size=[5000; 10000; 15000; 20000; 25000];
for i=1:length(window_size)
    
        filtEMG = filterEMG(rawEMG(:,1:window_size(i)), samplingFreq, lowFcutoff, hiFcutoff);
        [EMGobj] = getEMGfeaturesTD(filtEMG);
        X=[EMGobj.VAR, EMGobj.MAV, EMGobj.WL, EMGobj.ZC, EMGobj.SSC];
        
        X_train_temp=X([1 25 26 50 51 75 76 100],:);
        Y_train_temp=Y([1 25 26 50 51 75 76 100],:);
        
        rand_num=randperm(length(X_train_temp));
        
        X_train= X_train_temp(rand_num,:);
        Y_train= Y_train_temp(rand_num,:);
        
       
        X_test_temp=[X(2:24,:);X(27:49,:);X(52:74,:);X(77:99,:)];
        Y_test_temp=[Y(2:24,:);Y(27:49,:);Y(52:74,:);Y(77:99,:)];
        
        rand_num_test=randperm(length(X_test_temp));
        
        X_test= X_test_temp(rand_num_test,:);
        Y_test(:,i)= Y_test_temp(rand_num_test,:);
        
        
        predict1= classifySVMoffline(X_train', Y_train', X_test', Y_test');
        predict(:,i)=predict1';
            
end


 for j=1:length(window_size)
     
        figure(j);  
        [Cmat,DA]= confusion_matrix(predict(:,j),Y_test(:,j),{'weak','strong','slow','fast'});
        title(sprintf('%s %d %s %.3f\n','Classification of EMG signals of size',window_size(j)*dt,'ms, P=',DA/100));        
        D(:,j) = diag(Cmat)*100;

 end


for n=1:length(window_size)
        figure(n);  
        X = categorical({'Weak','Strong','Slow','Fast'});
        X = reordercats(X,{'Weak','Strong','Slow','Fast'});
        bar(X,D(:,n),'BarWidth',0.25,'FaceColor','k')
        hold on 
        yl = yline(25,'--','Chance level','LineWidth',3, 'color', 'r');
        ylabel('Performance [%]')
        title(sprintf('%s %d %s','classification performance of EMG signals of size',window_size(j)*dt,'ms'));
end






















% %% from 0 to the first window 
% time=[1, 5000, 10000, 15000, 20000];
% 
% filtEMG = filterEMG(rawEMG(:,time(1,1):time(1,2)), samplingFreq, lowFcutoff, hiFcutoff);
%         [EMGobj] = getEMGfeaturesTD(filtEMG);
%         X=[EMGobj.VAR, EMGobj.MAV, EMGobj.WL, EMGobj.ZC, EMGobj.SSC];
%         
%         X_train_temp=X([1 25 26 50 51 75 76 100],:);
%         Y_train_temp=Y([1 25 26 50 51 75 76 100],:);
%         rand_num=randperm(length(X_train_temp));
%         X_train= X_train_temp(rand_num,:);
%         Y_train= Y_train_temp(rand_num,:);
%         
%        
%         X_test_temp=[X(2:24,:);X(27:48,:);X(52:74,:);X(77:100,:)];
%         Y_test_temp=[Y(2:24,:);Y(27:48,:);Y(52:74,:);Y(77:100,:)];
%         rand_num_test=randperm(length(X_test_temp));
%         X_test= X_test_temp(rand_num_test,:);
%         Y_test= Y_test_temp(rand_num_test,:);
%         
%         
%         predict1= classifySVMoffline(X_train', Y_train', X_test', Y_test');
%         test_accuracy_start = sum(predict1' == Y_test)/length(Y_test);
% %         [Cmat,DA]= confusion_matrix(predict1',Y_test,{'weak','strong','slow','fast'});
% %% one window 
% filtEMG = filterEMG(rawEMG(:,time(1,1):time(1,3)), samplingFreq, lowFcutoff, hiFcutoff);
%         [EMGobj] = getEMGfeaturesTD(filtEMG);
%         X=[EMGobj.VAR, EMGobj.MAV, EMGobj.WL, EMGobj.ZC, EMGobj.SSC];
%         
%         X_train_temp=X([1 25 26 50 51 75 76 100],:);
%         Y_train_temp=Y([1 25 26 50 51 75 76 100],:);
%         rand_num=randperm(length(X_train_temp));
%         X_train= X_train_temp(rand_num,:);
%         Y_train= Y_train_temp(rand_num,:);
%         
%        
%         X_test_temp=[X(2:24,:);X(27:48,:);X(52:74,:);X(77:100,:)];
%         Y_test_temp=[Y(2:24,:);Y(27:48,:);Y(52:74,:);Y(77:100,:)];
%         rand_num_test=randperm(length(X_test_temp));
%         X_test= X_test_temp(rand_num_test,:);
%         Y_test= Y_test_temp(rand_num_test,:);
%         
%         
%         predict1= classifySVMoffline(X_train', Y_train', X_test', Y_test');
%         test_accuracy_one = sum(predict1' == Y_test)/length(Y_test);
% %         [Cmat,DA]= confusion_matrix(predict1',Y_test,{'weak','strong','slow','fast'});
% %% %% 2 windows 
% filtEMG = filterEMG(rawEMG(:,time(1,1):time(1,4)), samplingFreq, lowFcutoff, hiFcutoff);
%         [EMGobj] = getEMGfeaturesTD(filtEMG);
%         X=[EMGobj.VAR, EMGobj.MAV, EMGobj.WL, EMGobj.ZC, EMGobj.SSC];
%         
%         X_train_temp=X([1 25 26 50 51 75 76 100],:);
%         Y_train_temp=Y([1 25 26 50 51 75 76 100],:);
%         rand_num=randperm(length(X_train_temp));
%         X_train= X_train_temp(rand_num,:);
%         Y_train= Y_train_temp(rand_num,:);
%         
%        
%         X_test_temp=[X(2:24,:);X(27:48,:);X(52:74,:);X(77:100,:)];
%         Y_test_temp=[Y(2:24,:);Y(27:48,:);Y(52:74,:);Y(77:100,:)];
%         rand_num_test=randperm(length(X_test_temp));
%         X_test= X_test_temp(rand_num_test,:);
%         Y_test= Y_test_temp(rand_num_test,:);
%         
%         
%         predict1= classifySVMoffline(X_train', Y_train', X_test', Y_test');
%         test_accuracy_two = sum(predict1' == Y_test)/length(Y_test);
% %         [Cmat,DA]= confusion_matrix(predict1',Y_test,{'weak','strong','slow','fast'});
% %% 
% filtEMG = filterEMG(rawEMG(:,time(1,1):time(1,5)), samplingFreq, lowFcutoff, hiFcutoff);
%         [EMGobj] = getEMGfeaturesTD(filtEMG);
%         X=[EMGobj.VAR, EMGobj.MAV, EMGobj.WL, EMGobj.ZC, EMGobj.SSC];
%         
%         X_train_temp=X([1 25 26 50 51 75 76 100],:);
%         Y_train_temp=Y([1 25 26 50 51 75 76 100],:);
%         rand_num=randperm(length(X_train_temp));
%         X_train= X_train_temp(rand_num,:);
%         Y_train= Y_train_temp(rand_num,:);
%         
%        
%         X_test_temp=[X(2:24,:);X(27:48,:);X(52:74,:);X(77:100,:)];
%         Y_test_temp=[Y(2:24,:);Y(27:48,:);Y(52:74,:);Y(77:100,:)];
%         rand_num_test=randperm(length(X_test_temp));
%         X_test= X_test_temp(rand_num_test,:);
%         Y_test= Y_test_temp(rand_num_test,:);
%         
%         
%         predict1= classifySVMoffline(X_train', Y_train', X_test', Y_test');
%         test_accuracy_three = sum(predict1' == Y_test)/length(Y_test);
% %         [Cmat,DA]= confusion_matrix(predict1',Y_test,{'weak','strong','slow','fast'});
% %% %% 3 windows 
% filtEMG = filterEMG(rawEMG, samplingFreq, lowFcutoff, hiFcutoff);
% %% 
%         [EMGobj] = getEMGfeaturesTD(filtEMG);
%         X=[EMGobj.VAR, EMGobj.MAV, EMGobj.WL, EMGobj.ZC, EMGobj.SSC];
%         
%         X_train_temp=X([1 25 26 50 51 75 76 100],:);
%         Y_train_temp=Y([1 25 26 50 51 75 76 100],:);
%         rand_num=randperm(length(X_train_temp));
%         X_train= X_train_temp(rand_num,:);
%         Y_train= Y_train_temp(rand_num,:);
%         
%        
%         X_test_temp=[X(2:24,:);X(27:48,:);X(52:74,:);X(77:100,:)];
%         Y_test_temp=[Y(2:24,:);Y(27:48,:);Y(52:74,:);Y(77:100,:)];
%         rand_num_test=randperm(length(X_test_temp));
%         X_test= X_test_temp(rand_num_test,:);
%         Y_test= Y_test_temp(rand_num_test,:);
%         
%         
%         predict1= classifySVMoffline(X_train', Y_train', X_test', Y_test');
%         test_accuracy_whole = sum(predict1' == Y_test)/length(Y_test);
% %         [Cmat,DA]= confusion_matrix(predict1',Y_test,{'weak','strong','slow','fast'});
% %% Plots
% figure(1);clf
% sgtitle('Noise level: 20%')
% subplot(4,1,1)
% plot(rawEMG(25,:),'r') %the first sample=weak e_amp=5'
% hold on 
% plot(filtEMG(25,:),'k') %the first sample=weak e_amp=5'
% ylabel('\mu V')
% axis tight
% legend('raw_EMG','filtered_EMG')
% title('Weak')
% axis tight
% xline(5000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% xline(10000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% xline(15000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% xline(20000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% xline(25000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% hold off  
% 
% subplot(4,1,2)
% plot(rawEMG(50,:),'b')
% hold on 
% plot(filtEMG(50,:),'k') %the first sample=weak e_amp=5'
% ylabel('\mu V')
% axis tight
% legend('raw_EMG','filtered_EMG')
% title('Strong')
% axis tight
% xline(5000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% xline(10000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% xline(15000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% xline(20000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% xline(25000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% hold off 
% 
% subplot(4,1,3)
% plot(rawEMG(75,:),'g')
% hold on 
% plot(filtEMG(75,:),'k') %the first sample=weak e_amp=5'
% ylabel('\mu V')
% axis tight
% legend('raw_EMG','filtered_EMG')
% title('Slow')
% axis tight
% xline(5000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% xline(10000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% xline(15000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% xline(20000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% xline(25000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% hold off 
% 
% subplot(4,1,4)
% plot(rawEMG(100,:),'c')
% hold on 
% plot(filtEMG(100,:),'k') %the first sample=weak e_amp=5'
% ylabel('\mu V')
% legend('raw_EMG','filtered_EMG')
% axis tight
% title('Fast')
% xline(5000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% xline(10000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% xline(15000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% xline(20000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% xline(25000, 'color', 'm', 'LineWidth',1,'HandleVisibility','off')
% 
% hold off 
% 
% subplot(5,1,5)
% plot(time,[test_accuracy_start, test_accuracy_one, test_accuracy_two, test_accuracy_three, test_accuracy_whole])
% grid on
% grid minor 
% title('How long to record to have a good accuracy')
% ylabel('#trueClass/#objects')
% xlabel('time')