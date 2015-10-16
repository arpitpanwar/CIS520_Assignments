% Numerical illustration of connection between constrained optimization and
% penalized regression for the LASSO estimator.
% 
% This illustrates that when w is an optimal solution to the constrained 
% optimization problem (1) and lambda is the lagrange multiplier associated 
% with w, then w is also an optimal solution of the penalized regression 
% problem (3) with penalty coefficient lambda.
%
% Supplement to CIS 520, HW 5.

% Define a matrix of X values
X = normrnd(0, 1, 300, 10);

% Define a vector of response values Y which are linear combinations of
% some of the X values, plus some noise
Y = X(:,1)+2*X(:,2)+3*X(:,3)+4*X(:,4) + normrnd(0,5,300,1);

% Compute the OLS solution. We will use this as a starting point in the
% numerical optimization.
w_MLE = (X'*X)\(X'*Y);

% Now we will minimize constrained optimization problem (1) in the homework

% Define the constraint constant to be used in the constraint (2) in the
% homework
t = 10;

% Compute the constraint value. nonlcon = "Non-linear constraint",
% used in fmincon.
nonlcon = @(w) sumabs(w,t); % see sumabs.m

% Set options for numerical optimization
options = optimset('MaxIter',10000,'Display','off'); % Set options for numerical optimization

% fmincon: minimize a function subject to constraints.
% Numerically optimize the objective function of (1) using the non-linear
% constraint (2), which says that the L1 norm of w must be less than t
% w_OPT is an optimal w for the constrained optimization problem.
w_OPT = fmincon( @(w) 0.5*sum( ( Y - X*w ).^2 ), w_MLE, [],[],[],[],[],[], nonlcon, options);

% Compute lambda based on the result in Osborne.
% This lambda is the Lagrange multiplier associated with w_OPT in the dual
% problem (actually, these are numerical estimates, but they are close)
lambda = (Y - X*w_OPT)' * X * w_OPT / sum(abs(w_OPT));

% Use the same lambda as the regularization term in the penalized
% regression problem (3) in the homework.

% Observe that when we use w_MLE to begin the search, the new optimal output
% w_PEN is barely different from w_OPT.
% This confirms that w_OPT is also an (approximately) optimal solution for
% the penalized regression problem (3).
% w_PEN_1 is an optimal w for the penalized regression problem
w_PEN_1 = fminsearch( @(w) 0.5*sum( ( Y - X*w ).^2 ) + lambda * sum(abs(w)), w_MLE, options);

% Note that when we use w_OPT itself to begin the search, the optimal w
% found in the search is virtually unchanged from w_OPT
% w_PEN_2 is an optimal w for the penalized regression problem
w_PEN_2 = fminsearch( @(w) 0.5*sum( ( Y - X*w ).^2 ) + lambda * sum(abs(w)), w_OPT, options);

% This can be run many times to see the result repeated for new
% randomly-generated data sets.
