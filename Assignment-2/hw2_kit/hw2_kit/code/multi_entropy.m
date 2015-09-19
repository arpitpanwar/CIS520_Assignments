function [H] = multi_entropy(p)
% MULTI_ENTROPY - Compute H(P(X)) for discrete multi-valued X.
%
% Usage:
% 
%    H = multi_entropy(P)
%
%  Returns the entropy H = -\sum_x p(x) * log(p(x)).
%  For an K X N matrix P, H is a 1 x N vector of entropy for each of the 
%  N distributions over K values.

% YOUR CODE GOES HERE
%p = double(p);
p_times_logp = @(x) min(0, x.*log2(x));
H = -sum(p_times_logp(p));

% 
% [K N] = size(p);
% 
% H = ones(1,N);
% 
% for i = 1:N
%     p_temp = p (:,i);
%     H(1,i) = -(sum(p_times_logp(p_temp)));
% end
