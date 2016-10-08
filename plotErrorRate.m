clear
close all
run weightChange1.m
run weightChange2.m
run weightChange3.m
plot(ep, errorConverge, ep, errorConverge2, '--', ep, errorConverge3, '-.')
legend('weight change 1', 'weight change 2', 'weight change 3')
xlabel('number of epochs')
ylabel('error rate')
title('Error rate vs. epoch (\eta = 0.0001)')
xlim([0, 600])