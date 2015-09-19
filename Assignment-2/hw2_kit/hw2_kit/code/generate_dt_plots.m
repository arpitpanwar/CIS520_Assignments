%% Script/instructions on how to submit plots/answers for question 3.
% Put your textual answers where specified in this script and run it before
% submitting.

% Loading the data
data = load('../data/mnist_all.mat');

    % Running a training set for binary decision tree classifier
    [X Y] = get_digit_dataset(data, {'7','9'}, 'train');
    
    %% Train a depth 4 binary decision tree
    dt = dt_train(X, Y, 4);
    
    %%
    [Xtest Ytest] = get_digit_dataset(data, {'7','9'}, 'test');
    Yhat = zeros(size(Ytest));
    for i = 1:size(Xtest,1)
        Yhat(i) = dt_value(dt, Xtest(i,:)) >= 0.5;
    end
    
    mean(Yhat ~= Ytest)
    
    %% 3.1
    answers{1} = 'There doesnt seem to be any overfitting';
    
    d = [1:1:6];
    
    [Xtrain Ytrain] = get_digit_dataset(data, {'1','3','7'}, 'train');
    [Xtest Ytest] = get_digit_dataset(data, {'1','3','7'}, 'test');
    
    roots = zeros([1,6]);
    train_err = zeros([1,6]);
    test_err = zeros([1,6]);
    for i = 1:6
        dt = dt_train_multi(Xtrain,Ytrain,i);   
        
        Yhat = zeros(size(Ytest));
        
        for j = 1:size(Xtest,1)
           [Yval Yhat(j)] = max(dt_value(dt, Xtest(j,:)));
        end
        test_err(1,i) = sum(Yhat ~= Ytest)/length(Ytest);
        
         Yhat_train = zeros(size(Ytrain));
         for j = 1:size(Xtrain,1)
             Yhat_train(j) = max(dt_value(dt, Xtrain(j,:)));
         end
        train_err(1,i) = sum(Yhat_train ~= Ytrain)/length(Ytrain);
    end
    
plot(d, test_err);
hold on;
plot(d,train_err);
xlabel('Depth');
ylabel('Mean Error');

% Saving your plot: once you have succesfully plotted your data; e.g.,
% something like:
% >> plot(depth, [train_err test_err]);
% Remember: You can save your figure to a .jpg file as follows:
% >> print -djpg plot_3.1.jpg

%% 3.2
answers{2} = 'biggest mistake in digits 3,5';


[Xtest Ytest] = get_digit_dataset(data, {'0','1','2','3','4','5','6','7','8','9'}, 'test');
[Xtrain Ytrain] = get_digit_dataset(data, {'0','1','2','3','4','5','6','7','8','9'}, 'train');

trainRoot = dt_train_multi(Xtrain,Ytrain,6);
Yhat = zeros(size(Ytest));
for i = 1:size(Xtest,1) 
   [Yval Yhat(i)] = max(dt_value(trainRoot, Xtest(i,:)));
end

M = zeros([10,10]);

for i=1:size(Ytest,1)
        ty = Ytest(i);
        tyh = Yhat(i);
        M(ty,tyh) =  M(ty,tyh)+1;
end
M=M./sum
plotnumeric(M);
save -ascii confusion.txt M;

% Saving your plot: once you've computed M, plot M with the plotnumeric.m
% command we've provided. e.g:
% >> plotnumeric(M);
%
% Save your file to plot_3.2.jpg
%
% ***** ALSO *******
% Save your confusion matrix M to a .txt file as follows:
% >> save -asci confusion.txt M

%% 3.3
answers{3} = 'The failure was in differentiating between 3 and 8. It was because a few pixels on the left were misclassified leading to it looking like an 8';



[Xtest Ytest] = get_digit_dataset(data, {'0','1','2','3','4','5','6','7','8','9'}, 'test');
[Xtrain Ytrain] = get_digit_dataset(data, {'0','1','2','3','4','5','6','7','8','9'}, 'train');

trainRoot = dt_train_multi(Xtrain,Ytrain,6);
Yhat = zeros(size(Ytest));
for i = 1:size(Xtest,1) 
   [Yval Yhat(i)] = max(dt_value(trainRoot, Xtest(i,:)));
end

plot_dt_digit(trainRoot,Xtest(2304,:));

% E.g., if Xtest(i,:) is an example your method fails on, call:
% >> plot_dt_digit(tree, Xtest(i,:));
%
% Save your file to plot_3.3.jpg

%% Finishing up - make sure to run this before you submit.
save('problem_3_answers.mat', 'answers');