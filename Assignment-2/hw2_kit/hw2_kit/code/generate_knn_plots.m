%% Script/instructions on how to submit plots/answers for question 2.
% Put your textual answers where specified in this script and run it before
% submitting.

% Loading the data: this loads X, Xnoisy, and Y.
load('../data/breast-cancer-data-fixed.mat');

%% 2.1
answers{1} = 'Error reduces as the number of folds increase but becomes constant afer 4 folds. For noisy data the error reduces at a high rate till fold count is 8 and after that the rate is really low.';
% K =1;
% N = [2, 4, 8, 16];
% nfold_errs = zeros(100,4);
% nfold_errs_noisy = zeros(100,4);
% predicted_test_error = zeros(100,1);
% predicted_test_error_noisy = zeros(100,1);
% for i=1:100
%     p = randperm(size(X,1),400);
%     x_split = X(p,:);
%     test_data = X(~p,:);
%     test_data_noisy = X_noisy(~p,:);
%     p1 = randperm(size(X_noisy,1),400);
%     x1_split = X_noisy(p1,:);
%     y1_split = Y(p1);
%     y_split = Y(p);
%     test_labels = Y(~p);
%     test_labels_noisy = Y(~p1);
%     for j=1:4
%        part = make_xval_partition(size(x_split,1),N(j));
%        part1 = make_xval_partition(size(x1_split,1),N(j));
%        nfold_errs(i,j) = knn_xval_error(K, x_split, y_split, part, 'l2');
%        nfold_errs_noisy(i,j) = knn_xval_error(K, x1_split, y1_split, part1, 'l2');
%     end
%     predicted_test_labels = knn_test(K, x_split,y_split,test_data,'l2');
%     predicted_test_error(i,1) = sum(test_labels ~= sign(predicted_test_labels))/length(test_labels);
%     predicted_test_labels_noisy = knn_test(K, x1_split,y1_split,test_data_noisy,'l2');
%     predicted_test_error_noisy(i,1) = sum(test_labels_noisy ~= sign(predicted_test_labels_noisy))/length(test_labels_noisy);
%     
% end
% y = mean(nfold_errs);
% e = std(nfold_errs);
% x = [2 4 8 16];
% y_noisy = mean(nfold_errs_noisy);
% e_noisy = std(nfold_errs_noisy);
% y_test = mean(predicted_test_error);
% e_test = std(predicted_test_error);
% y_test_noisy = mean(predicted_test_error_noisy);
% e_test_noisy = std(predicted_test_error_noisy);
% 
% %subplot(2,1,1);
% %errorbar(x, y, e);
% 
% %subplot(2,1,2);
% for k=1:4
%   %  errorbar(x(k), y_test, e_test);
% end
% 
% %subplot(2,1,1);
% errorbar(x, y_noisy, e_noisy);
% xlabel('Folds');
% ylabel('Mean error');
% %subplot(2,1,1);
% for k=1:4
%  %   errorbar(x(k), y_test_noisy, e_test_noisy);
% end



       

% Plotting with error bars: first, arrange your data in a matrix as
% follows:
%
%  nfold_errs(i,j) = nfold error with n=j of i'th repeat
%  
% Then we want to plot the mean with error bars of standard deviation as
% folows: y = mean(nfold_errs), e = std(nfold_errs), x = [2 4 8 16].
% 
% >> errorbar(x, y, e);
%
% Along with nfold_errs, also plot errorbar for test error. This will 
% serve as measure of performance for different nfold-crossvalidation.
%
% To add labels to the graph, use xlabel('X axis label') and ylabel
% commands. To add a title, using the title('My title') command.
% See the class Matlab tutorial wiki for more plotting help.
% 
% Once your plot is ready, save your plot to a jpg by selecting the figure
% window and running the command:
%
% >> print -djpg plot_2.1-noisy.jpg % (for noisy version of data)
% >> print -djpg plot_2.1.jpg  % (for regular version of data)
%
% YOU MUST SAVE YOUR PLOTS TO THESE EXACT FILES.

%% 2.2
answers{2} = 'Sigma for normal data = 4 , Sigma for noisy data = 6 and K for normal data = 3 and for noisy data K =9';

% K_2 = [1:2:15];
% N = 10;
% nfold_errs = zeros(100,4);
% nfold_errs_noisy = zeros(100,4);
% predicted_test_error = zeros(100,size(K_2,2));
% predicted_test_error_noisy = zeros(100,size(K_2,2));
% for i=1:100
%     p = randperm(size(X,1),400);
%     x_split = X(p,:);
%     test_data = X(~p,:);
%     test_data_noisy = X_noisy(~p,:);
%     p1 = randperm(size(X_noisy,1),400);
%     x1_split = X_noisy(p1,:);
%     y1_split = Y(p1);
%     y_split = Y(p);
%     test_labels = Y(~p);
%     test_labels_noisy = Y(~p1);
%     for j=1:size(K_2,2)
%        part = make_xval_partition(size(x_split,1),N);
%        part1 = make_xval_partition(size(x1_split,1),N);
%        nfold_errs(i,j) = knn_xval_error(K_2(j), x_split, y_split, part, 'l2');
%        nfold_errs_noisy(i,j) = knn_xval_error(K_2(j), x1_split, y1_split, part1, 'l2');
%        predicted_test_labels = knn_test(K_2(j), x_split,y_split,test_data,'l2');
%        predicted_test_error(i,j) = (1/size(test_data,1)) * sum(test_labels ~= sign(predicted_test_labels));
%        predicted_test_labels_noisy = knn_test(K_2(j), x1_split,y1_split,test_data_noisy,'l2');
%        predicted_test_error_noisy(i,j) = sum(test_labels_noisy ~= sign(predicted_test_labels_noisy))/size(test_labels_noisy,1);
%     end
% end
% y = mean(nfold_errs);
% e = std(nfold_errs);
% y_noisy = mean(nfold_errs_noisy);
% e_noisy = std(nfold_errs_noisy);
% y_test = mean(predicted_test_error);
% e_test = std(predicted_test_error);
% y_test_noisy = mean(predicted_test_error_noisy);
% e_test_noisy = std(predicted_test_error_noisy);
% 
% errorbar(K_2,y_noisy,e_noisy);
% hold;
% errorbar(K_2,y_test_noisy,e_test_noisy);

sigma = [1:1:8];
N = 10;
nfold_errs = zeros(100,4);
nfold_errs_noisy = zeros(100,4);
predicted_test_error = zeros(100,size(K_2,2));
predicted_test_error_noisy = zeros(100,size(K_2,2));
for i=1:100
    p = randperm(size(X,1),400);
    x_split = X(p,:);
    test_data = X(~p,:);
    test_data_noisy = X_noisy(~p,:);
    p1 = randperm(size(X_noisy,1),400);
    x1_split = X_noisy(p1,:);
    y1_split = Y(p1);
    y_split = Y(p);
    test_labels = Y(~p);
    test_labels_noisy = Y(~p1);
    for j=1:size(sigma,2)
       part = make_xval_partition(size(x_split,1),N);
       part1 = make_xval_partition(size(x1_split,1),N);
       nfold_errs(i,j) = kernreg_xval_error(sigma(j), x_split, y_split, part, 'l2');
       nfold_errs_noisy(i,j) = kernreg_xval_error(sigma(j), x1_split, y1_split, part1, 'l2');
       predicted_test_labels = kernreg_test(sigma(j), x_split,y_split,test_data,'l2');
       predicted_test_error(i,j) = (1/size(test_data,1)) * sum(test_labels ~= sign(predicted_test_labels));
       predicted_test_labels_noisy = kernreg_test(sigma(j), x1_split,y1_split,test_data_noisy,'l2');
       predicted_test_error_noisy(i,j) = sum(test_labels_noisy ~= sign(predicted_test_labels_noisy))/size(test_labels_noisy,1);
    end
end
y = mean(nfold_errs);
e = std(nfold_errs);
y_noisy = mean(nfold_errs_noisy);
e_noisy = std(nfold_errs_noisy);
y_test = mean(predicted_test_error);
e_test = std(predicted_test_error);
y_test_noisy = mean(predicted_test_error_noisy);
e_test_noisy = std(predicted_test_error_noisy);

errorbar(sigma,y,e);
hold;
errorbar(sigma,y_test,e_test);
xlabel('Sigma');
ylabel('Mean Error');
% Save your plots as follows:
%
%  noisy data, k-nn error vs. K --> plot_2.2-k-noisy.jpg
%  noisy data, kernreg error vs. sigma --> plot_2.2-sigma-noisy.jpg
%  regular data, k-nn error vs. K --> plot_2.2-k.jpg
%  regular data, kernreg error vs. sigma --> plot_2.2-sigma.jpg

%% Finishing up - make sure to run this before you submit.
save('problem_2_answers.mat', 'answers');
