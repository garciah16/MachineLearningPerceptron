clear all
load('trainingSet.mat');
load('cx.mat');
load('firstweights.mat');
hx = zeros(100, 1);
for i = 1:100
    result = sum(weights .* trainingSet(i, :));
    if(result > 0)
        hx(i, 1) = 1;
    else
        hx(i, 1) = 0;
    end
end
save('hx.mat', 'hx');