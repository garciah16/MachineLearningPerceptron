clear all
load('trainingSet.mat')
load('cx.mat')

firstWeights = 2*rand(1,4)-1;
numEpoch = 500;
N = logspace(-1, 0, numEpoch);
epochConv1 = zeros(1, numEpoch);
epochConv2 = zeros(1, numEpoch);
epochConv3 = zeros(1, numEpoch);

% run loop for first weight change method
for nLoop = 1:length(N)
    % we must reload the h(x) and weights for each runthrough
    load('hx.mat')
    %load('firstweights.mat')
    weights = firstWeights;
    
    errorConverge = zeros(numEpoch, 1);

    for epoch = 1:numEpoch;
        errorCounter = 0;
        for i = 1:100
            
            %recalculate hx for ith example for next time
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
                    weights(j) = weights(j) + (N(nLoop) * C * trainingSet(i, j));
                end
            end
        end
        totErr = errorCounter/100;
        errorConverge(epoch) = totErr;
        if(totErr == 0)
            % update the epoch of convergence for this N
            epochConv1(nLoop) = epoch;
            break
        end
    end
end

% run second weight change method
for nLoop = 1:length(N)
    % we must reload the h(x) and weights for each runthrough
    load('hx.mat')
    %load('firstweights.mat')
    weights = firstWeights;
    
    errorConverge = zeros(numEpoch, 1);

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
                CSumDiff = cx(i) - sum(weights .* trainingSet(i, :));
                for j = 1:4
                    weights(j) = weights(j) + (N(nLoop) * CSumDiff * trainingSet(i, j));
                end
                
            end
        end
        totErr = errorCounter/100;
        errorConverge(epoch) = totErr;
        if(totErr == 0)
            % update the epoch of convergence for this N
            epochConv2(nLoop) = epoch;
            break
        end
    end
end  

%{
% run third weight change method
for nLoop = 1:length(N)
    % we must reload the h(x) and weights for each runthrough
    load('hx.mat')
    load('firstweights.mat')
    
    errorConverge = zeros(numEpoch, 1);

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
                CSumDiff = cx(i) - sum(weights .* trainingSet(i, :));
            
                for j = 1:4
                    weights(j) = weights(j) + (N(nLoop) * CSumDiff);
                end
            
                
            end
        end
        totErr = errorCounter/100;
        errorConverge(epoch) = totErr;
        if(totErr == 0)
            % update the epoch of convergence for this N
            epochConv3(nLoop) = epoch;
            break
        end
    end
end 
%}

semilogx(N,epochConv1, N, epochConv2, '--')
legend('weight method 1', 'weight method 2')                        
ylabel('Epoch of convergence to zero error')
xlabel('\eta value (log scale)')
title('Weight Change Methods Comparison')
ylim([1 max(epochConv2)])
str1 = ['The first weights were: w0 = ', num2str(firstWeights(1)), ' w1 = ', num2str(firstWeights(2)), ' w2 = ', num2str(firstWeights(3)), ' w3 = ', num2str(firstWeights(4))];
disp(str1)
str2 = ['The final weights were: w0 = ', num2str(weights(1)), ' w1 = ', num2str(weights(2)), ' w2 = ', num2str(weights(3)), ' w3 = ', num2str(weights(4))];
disp(str2)