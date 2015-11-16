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

[idx_5,C_5] = kmeans(traindata_5,153,'MaxIter',300);
[idx_10,C_10] = kmeans(traindata_10,153,'MaxIter',300);
[idx_20,C_20] = kmeans(traindata_20,153,'MaxIter',300);

clusterMap_5 = zeros(153,1);
clusterMap_10 = zeros(153,1);
clusterMap_20 = zeros(153,1);

for i=1:153
    tempClusterVal = idx_5(:,1) ==i;
    vals = trainset.letter(tempClusterVal);
    clusterMap_5(i) = mode(vals);
    
    tempClusterVal = idx_10(:,1) ==i;
    vals = trainset.letter(tempClusterVal);
    clusterMap_10(i) = mode(vals);
    
    tempClusterVal = find(idx_20(:,1) ==i);
    vals = trainset.letter(tempClusterVal);
    clusterMap_20(i) = mode(vals);
end

closest_5 = zeros(size(testdata_5,1),1);
closest_10 = zeros(size(testdata_10,1),1);
closest_20 = zeros(size(testdata_20,1),1);

for i=1:size(testdata_5,1)
    distances_5 = sqrt(sum(bsxfun(@minus, C_5, testdata_5(i,:)).^2,2));
    closest_5(i) = clusterMap_5(distances_5==min(distances_5));

    distances_10 = sqrt(sum(bsxfun(@minus, C_10, testdata_10(i,:)).^2,2));
    closest_10(i) = clusterMap_10(distances_10==min(distances_10));

    distances_20 = sqrt(sum(bsxfun(@minus, C_20, testdata_20(i,:)).^2,2));
    closest_20(i) = clusterMap_20(distances_20==min(distances_20));
end

error_5 = find(closest_5 ~= testset.letter);
error_10 = find(closest_10 ~= testset.letter);
error_20 = find(closest_20 ~= testset.letter);

errorval_5 = size(error_5,1)/size(testset.letter,1);
errorval_10 = size(error_10,1)/size(testset.letter,1);
errorval_20 = size(error_20,1)/size(testset.letter,1);


[idx,C] = kmeans(trainset.pixels,153,'MaxIter',300);
closest = zeros(size(testset.pixels,1),1);
clusterMap = zeros(153,1);

for i=1:153
    tempClusterVal = idx(:,1) ==i;
    vals = trainset.letter(tempClusterVal);
    clusterMap(i) = mode(vals);
end

for i=1:size(testset.pixels,1)
    distances = sqrt(sum(bsxfun(@minus, C, testset.pixels(i,:)).^2,2));
    closest(i) = clusterMap(distances==min(distances));
end

errorOrig = find(closest ~= testset.letter);
errorValOrig = size(errorOrig,1)/size(testset.letter,1);
