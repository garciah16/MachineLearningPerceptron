% implement w(i) = w(i) + N*[c(x)-h(x)]*x(i)
clear all
load('trainingSet.mat')
load('cx.mat')


numEpoch = 6000;
N = logspace(-5, -1, numEpoch);
epochConv = zeros(1, numEpoch);

for nLoop = 1:length(N)
    % we must reload the h(x) and weights for each runthrough
    load('hx.mat')
    load('firstweights.mat')
    
    errorConverge = zeros(numEpoch, 1);

    for epoch = 1:numEpoch;
        errorCounter = 0;
        for i = 1:100
            C = cx(i) - hx(i);
            if(C ~= 0)
                errorCounter = errorCounter+1;
                % if we have an error, we need to recalculate the weights
                CSumDiff = cx(i) - sum(weights .* trainingSet(i, :));
                for j = 1:4
                    weights(j) = weights(j) + (N(nLoop) * CSumDiff * trainingSet(i, j));
                end
                % recalculate hx for ith example for next time
                resultH = sum(weights .* trainingSet(i, :));
                if(resultH > 0)
                    hx(i) = 1;
                else
                    hx(i) = 0;
                end
            end
        end
        totErr = errorCounter/100;
        errorConverge(epoch) = totErr;
        if(totErr == 0)
            % update the epoch of convergence for this N
            epochConv(nLoop) = epoch;
            break
        end
    end
end

loglog(N,epochConv)
ylabel('Epoch of convergence to zero error (log scale)')
xlabel('\eta value (log scale)')
title('Weight Change Method 2')