function [part] = make_xval_partition(n, n_folds)
% MAKE_XVAL_PARTITION - Randomly generate cross validation partition.
%
% Usage:
%
%  PART = MAKE_XVAL_PARTITION(N, N_FOLDS)
%
% Randomly generates a partitioning for N datapoints into N_FOLDS equally
% sized folds (or as close to equal as possible). PART is a 1 X N vector,
% where PART(i) is a number in (1...N_FOLDS) indicating the fold assignment
% of the i'th data point.

% YOUR CODE GOES HERE
part = [];
vals = floor(n/n_folds);
diff =  n-(vals*n_folds);

for i = 1:vals
    part = [part randperm(n_folds)];
end

if(diff > 0)
    diffRand = randperm(n_folds);
    part = [part diffRand(1:diff)];
end




