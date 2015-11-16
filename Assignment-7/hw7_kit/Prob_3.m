load('./data/ocr_data.mat');

%Select all rows in letters containing x
X = trainset.letter(testset.letter(:,1) == 24,:);
%Select all rows in letters containing x
Y = trainset.letter(testset.letter(:,1) == 25,:);

[xrow,xcol] = find(testset.letter(:,1) == 24);
[yrow,ycol] = find(testset.letter(:,1) == 25);

[xpixels] = testset.pixels(xrow,:);
[ypixels] = testset.pixels(yrow,:);

[coeff,score,latent] = pca(testset.pixels);
xscore = score(xrow,:);
yscore = score(yrow,:);

figure;
hold on;
scatter(xscore(:,1).*(-1),xscore(:,2),'x');
scatter(yscore(:,1).*(-1),yscore(:,2),'o');
hold off;
xlabel('PC1');
ylabel('PC2');
legend('boxon');

