clear all
% define xi within range [0, 1]
trainingSet = rand(100, 4);
% define x0 as 1 for all examples.
trainingSet(:, 1) = 1;
%create an negative attribute
trainingSet(1, :) = [1 1 0 0];
cx = zeros(100, 1);
for i = 1:100
    result = 1-trainingSet(i, 2)+trainingSet(i, 3)+trainingSet(i, 4);
    if(result > 0)
        %denote positive by 1
        cx(i, 1) = 1;
    else
        cx(i, 1) = 0;
    end
end
save('trainingSet.mat', 'trainingSet');
save('cx.mat', 'cx');