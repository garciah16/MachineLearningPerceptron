close all
load('trainingSet.mat')
%load('firstweights.mat')
%plot all positive examples
scatter3(trainingSet(2:end, 2),trainingSet(2:end, 3), trainingSet(2:end, 4))
hold on
%plot negative example with different marker
scatter3(trainingSet(1, 2), trainingSet(2, 3), trainingSet(3, 4), '*')
[x, y] = meshgrid(0:0.1:1);
z = -1/(weights(4))*(weights(2)*x + weights(3)*y + weights(1));
surf(x, y, z, 'FaceAlpha', 0.3)