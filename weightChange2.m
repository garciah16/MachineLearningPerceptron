% implement w(i) = w(i) + N*[c(x)-SUM(w(i)*x(i))]*x(i)
%clear all
load('trainingSet.mat')
load('cx.mat')
load('hx.mat')
load('firstweights.mat')

N = 0.0001;
numEpoch = 5000;
errorConverge2 = zeros(numEpoch, 1);
ep = 1:numEpoch;

for epoch = 1:numEpoch;
    errorCounter = 0;
    for i = 1:100
        C = cx(i) - hx(i);
        if(C ~= 0)
            errorCounter = errorCounter+1;
            % if we have an error, we need to recalculate the weights
            CSumDiff = cx(i) - sum(weights .* trainingSet(i, :));
            for j = 1:4
                weights(j) = weights(j) + (N * CSumDiff * trainingSet(i, j));
            end
            % recalculate hx for ith example
            resultH = sum(weights .* trainingSet(i, :));
            if(resultH > 0)
                hx(i) = 1;
            else
                hx(i) = 0;
            end
        end
    end
    totErr = errorCounter/100;
    errorConverge2(epoch) = totErr;
    if(totErr == 0)
        X = ['With N = ', num2str(N), ', error converged at epoch number ', num2str(epoch)];
        disp(X)
        break
    end
end

%plot(ep, errorConverge)
