load ./data/train.mat
load ./data/test.mat

%% pca
[ score_train,score_test, numpc] = pca_getpc( X_train,X_test );


%% auto encoder
addpath('./DL_toolbox/util','./DL_toolbox/NN','./DL_toolbox/DBN');

train_x = X_train/255;
test_x  = X_test/255;
[ dbn ] = rbm( train_x );
[ new_feat, new_feat_test ] = newFeature_rbm( dbn,train_x,test_x );


%% logistic 
addpath('./liblinear');
[ precision_ori_log ] = logistic( X_train, Y_train,X_test, Y_test );
[ precision_pca_log ] = logistic( score_train(:, 1:numpc), Y_train, score_test(:,1:numpc), Y_test );
[ precision_ae_log ] = logistic( new_feat, Y_train, new_feat_test, Y_test );

%% kmeans

K = [10, 25];
precision_ae_km = zeros(length(K), 1);
for i = 1 : length(K)
    k = K(i);
    precision_ae_km(i) = k_means(new_feat, Y_train, new_feat_test, Y_test, k);
end


precision_pc_km = zeros(length(K), 1);
for i = 1 : length(K)
    k = K(i);
    precision_pc_km(i) = k_means(score_train(:, 1:numpc), Y_train, score_test(:,1:numpc), Y_test, k);
end
