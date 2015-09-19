function [error] = knn_xval_error(K, X, Y, part, distFunc)
% KNN_XVAL_ERROR - KNN cross-validation error.
%
% Usage:
%
%   ERROR = knn_xval_error(K, X, Y, PART, DISTFUNC)
%
% Returns the average N-fold cross validation error of the K-NN algorithm on the 
% given dataset when the dataset is partitioned according to PART 
% (see MAKE_XVAL_PARTITION). DISTFUNC is the distance functioned 
% to be used (see KNN_TEST).
%
% Note that N = max(PART).
%
% SEE ALSO
%   MAKE_XVAL_PARTITION, KNN_TEST

% FILL IN YOUR CODE HERE
N = max(part);
E = zeros(1,N);
for i=1:N
    currPart = find(part==i);
    currNotPart = find((part~=i));
    train_points = X(currNotPart,:);
    test_points = X(currPart,:);
    train_labels = Y(currNotPart,:);
    test_labels = Y(currPart,:);
    [predicted_labels] = knn_test(K,train_points,train_labels,test_points,distFunc);
    E(i) = (1/size(test_points,1)) * sum(test_labels ~= sign(predicted_labels));
end

error = sum(E)/N;

    
    


