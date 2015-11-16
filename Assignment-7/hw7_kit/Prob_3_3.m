load('./data/ocr_data.mat');

pooledLetters = [trainset.letter;testset.letter];
pooledPixels = [trainset.pixels;testset.pixels];

[coeff,score,latent] = pca(pooledPixels);

pooleddata_5 = score(:,1:5);
pooleddata_10 = score(:,1:10);
pooleddata_20 = score(:,1:20);

trainsize = size(trainset.pixels,1);
pooledSize = size(pooledPixels,1);

traindata_5 = pooleddata_5(1:trainsize,:);
testdata_5 = pooleddata_5(trainsize+1:pooledSize,:);

traindata_10 = pooleddata_10(1:trainsize,:);
testdata_10 = pooleddata_10(trainsize+1:pooledSize,:);

traindata_20 = pooleddata_20(1:trainsize,:);
testdata_20 = pooleddata_20(trainsize+1:pooledSize,:);

model_5 = fitcnb(traindata_5,trainset.letter);
model_10 = fitcnb(traindata_10,trainset.letter);
model_20 = fitcnb(traindata_20,trainset.letter);

[label_5,Posterior_5,Cost_5] = predict(model_5,testdata_5);
[label_10,Posterior_10,Cost_10] = predict(model_10,testdata_10);
[label_20,Posterior_20,Cost_20] = predict(model_20,testdata_20);

error_5 = find(label_5 ~= testset.letter);
error_10 = find(label_10 ~= testset.letter);
error_20 = find(label_20 ~= testset.letter);

errorval_5 = size(error_5,1)/size(testset.letter,1);
errorval_10 = size(error_10,1)/size(testset.letter,1);
errorval_20 = size(error_20,1)/size(testset.letter,1);

origModel = fitcnb(trainset.pixels,trainset.letter,'Distribution','mn');
[label_orig,post_orig,cost_orig] = predict(origModel,testset.pixels);
errorOrig = find(label_orig ~= testset.letter);
errorValOrig = size(errorOrig,1)/size(testset.letter,1);


