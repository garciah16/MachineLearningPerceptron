% implement w(i) = w(i) + N*[c(x)-h(x)]*x(i)
clear all
close all
load('trainingSet.mat')
load('cx.mat')
load('hx.mat')
%load('firstweights.mat')
firstWeights = 2*rand(1, 4)-1;
weights = firstWeights;

N = 0.005;
numEpoch = 5000;
errorConverge = zeros(numEpoch, 1);
ep = 1:numEpoch;

% plot examples on a scatter plot
scatter3(trainingSet(2:end, 2),trainingSet(2:end, 3), trainingSet(2:end, 4), 'MarkerFaceColor', [0.5 0.5 0.9], 'MarkerEdgeColor', 'k')
hold on
% plot negative example with different marker
scatter3(trainingSet(1, 2), trainingSet(1, 3), trainingSet(1, 4), '*')
lowLim = -0.5;
upLim = 1.5;
[x, y] = meshgrid(lowLim:0.1:upLim);
xlim([lowLim,upLim])
ylim([lowLim,upLim])
zlim([lowLim upLim])
xlabel('x1')
ylabel('x2')
zlabel('x3')
title('Linear Classifier plane convergence')
view(-10,35)

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
        % if C is not 0, we must recalculate the weights
        if(C ~= 0)
            errorCounter = errorCounter+1;
            for j = 1:4
                weights(j) = weights(j) + (N * C * trainingSet(i, j));
            end
            
        end
        
    end
    % z = -1/(w3)*(w1*x + w2*y + w0)
    z = (-1)/(weights(4))*(weights(2)*x + weights(3)*y + weights(1));
    h1 = surf(x, y, z, 'FaceAlpha', 0.5, 'LineStyle', '--', 'EdgeAlpha', 0.2);
    pause(0.05)

    % check the error and break if there is none
    totErr = errorCounter/100;
    errorConverge(epoch) = totErr;
    if(totErr == 0)
        X = ['With N = ', num2str(N), ', error converged at epoch number ', num2str(epoch)];
        disp(X)
        break
    else
        delete(h1)
    end
end
title(['Linear classifier plane converged in ', num2str(epoch),' epochs'])