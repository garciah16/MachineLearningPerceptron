% implement w(i) = w(i) + N*[c(x)-h(x)]*x(i)
%clear all
load('trainingSet.mat')
load('cx.mat')
load('hx.mat')
load('firstweights.mat')

if(exist('N') ~= 1)
        N = 0.2;
end

numEpoch = 500;
errorConverge = zeros(numEpoch, 1);
ep = 1:numEpoch;

for epoch = 1:numEpoch;
    errorCounter = 0;
    for i = 1:100
        % recalculate hx for ith example for next time
        resultH = sum(weights .* trainingSet(i, :));
        if(resultH > 0)
            hx(i) = 1;
        else
            hx(i) = 0;
        end
        C = cx(i) - hx(i);
        if(C ~= 0)
            errorCounter = errorCounter+1;
            % if we have an error, we need to recalculate the weights
            for j = 1:4
                weights(j) = weights(j) + (N * C * trainingSet(i, j));
            end
            
        end
    end
    totErr = errorCounter/100;
    errorConverge(epoch) = totErr;
    if(totErr == 0)
        if(movieMode ~= 1)
            X = ['With N = ', num2str(N), ', error converged at epoch number ', num2str(epoch)];
            disp(X)
        end
        break
    end
end

%plot(ep, errorConverge)