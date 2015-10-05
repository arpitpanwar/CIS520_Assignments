function y = naive (w)
    load('data.mat');
    var = [1;1;1] .* w;
    y = norm(Y - X * var)^2 + nnz(var);
end
