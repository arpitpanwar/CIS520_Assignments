%% Plots/submission for SVM portion, Question 1.

addpath ./libsvm;

%% Put your written answers here.
clear all
answers{1} = 'Intersect kernel performs the best because it prevents overfitting by picking the minimum of the counts for the word from 2 documents';

save('problem_1_answers.mat', 'answers');

%% Load and process the data.

load ../data/windows_vs_mac.mat;
[X Y] = make_sparse(traindata, vocab);
[Xtest Ytest] = make_sparse(testdata, vocab);

%% Bar Plot - comparing error rates of different kernels

% INSTRUCTIONS: Use the KERNEL_LIBSVM function to evaluate each of the
% kernels you mentioned. Then run the line below to save the results to a
% .mat file.

results.linear = kernel_libsvm(X,Y,Xtest,Ytest,@(x,x2) kernel_poly(x, x2, 1));  % ERROR RATE OF LINEAR KERNEL GOES HERE
disp('After linear');
results.quadratic = kernel_libsvm(X,Y,Xtest,Ytest,@(x,x2) kernel_poly(x, x2, 2));% ERROR RATE OF QUADRATIC KERNEL GOES HERE
disp('After quadratic');
results.cubic = kernel_libsvm(X,Y,Xtest,Ytest,@(x,x2) kernel_poly(x, x2, 3)); % ERROR RATE OF CUBIC KERNEL GOES HERE
disp('After cubic');
results.gaussian = kernel_libsvm(X,Y,Xtest,Ytest,@(x,x2) kernel_gaussian(x, x2, 20));% ERROR RATE OF GAUSSIAN (SIGMA=20) GOES HERE
results.intersect = kernel_libsvm(X,Y,Xtest,Ytest,@(x,x2) kernel_intersection(x, x2)); % ERROR RATE OF INTERSECTION KERNEL GOES HERE

% Makes a bar chart showing the errors of the different algorithms.
algs = fieldnames(results);
for i = 1:numel(algs)
    y(i) = results.(algs{i});
end
bar(y);
set(gca,'XTickLabel', algs);
xlabel('Kernel');
ylabel('Test Error');
title('Kernel Comparisons');

print -djpeg -r72 plot_1.jpg;
