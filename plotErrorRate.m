clear
close all
for nLoop = 1:75
    
    if(nLoop == 58)
        db = 1;
    end
    movieMode = 1;
    Nvect = linspace(0.1, 1, 75);
    N = Nvect(nLoop);
    run('weightChange1.m')
    xlimit = epoch+5;
    run('weightChange2.m')
    if (epoch > xlimit && epoch < 500)
        xlimit = epoch;
    end
    run('weightChange3.m')
 
    grid on
    plot(ep, errorConverge, ep, errorConverge2, '--', ep, errorConverge3, '-.')
    legend('weight change 1', 'weight change 2', 'weight change 3')
    xlabel('number of epochs')
    ylabel('error rate')
    title(['Error rate vs. epoch (\eta = ', num2str(N), ')'])
    xlim([1, xlimit])
    ylim([0 max(errorConverge)+0.01])
    
    pause (0.75)
end