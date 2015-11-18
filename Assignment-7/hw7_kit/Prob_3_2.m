load('./data/ocr_data.mat');

%Select all rows in letters containing x
%Select all rows in letters containing x
pooledLetters = [trainset.letter;testset.letter];
pooledPixels = [trainset.pixels;testset.pixels];
avgPixels = pooledPixels;
avgimg = zeros(26,64);
for i=1:26
    [x,y] = find(pooledLetters(:,1) == i);
    temp1 = pooledPixels(x,:);
    avgimg(i,:) = mean(temp1);
    for j=1:size(x,1)
        avgPixels(x(j),:) = avgimg(i,:);
    end
end

error = zeros(64,1);
 
for i=1:64
    [residual,reconstructed] = pcares(pooledPixels,i);
    numerator = norm(reconstructed-avgPixels,'fro').^2;
    denominator = norm(pooledPixels-avgPixels,'fro').^2;
    error(i) =abs((numerator/denominator));
end

plot([1:64],error);
xlabel('Number of Dimensions');
ylabel('Accuracy');
