%% Betthauser - 2016 --  Compute SVM accuracy from data.  
% INPUTS: Atrain - training data (numF x N)
%         trainlabels - training data labels (1 x N)  
%         Atest - testing data (numF x P)
%         testlabels - testing data labels (1 x P)           
%         
% OUTPUT: [predict] - SVM predictions
function [predict1] = classifySVMoffline(Atrain, trainlabels, Atest, testlabels) 
    sizeTest = size(Atest,2);
    errors = 0;
%     t = templateSVM('Standardize',1,'KernelFunction','gaussian');
%     SVMobj = fitcecoc(Atrain',trainlabels,'Learners',t,'Coding','onevsone'); % good
    SVMobj = fitcecoc(Atrain',trainlabels);
    [predict1,~,~] = predict(SVMobj,Atest');
    predict1 = predict1';             
end