V0 = -65;
Rm = 10;
EL = V0;
Vth = -50;
tauM = 10;
iVals = 0:0.05:4;
numTimeSteps=2000;
freqVals = zeros(size(iVals));

for j = 1:length(iVals)
    curI = iVals(j);
    curV = V0;
    for t=0:numTimeSteps
        curV = curV + (EL - curV + Rm*curI)/tauM;
        if(curV > Vth)
           curV = V0;
           freqVals(j) = freqVals(j) + 1;
        end
    end
end

figure
plot(iVals,freqVals);
title('Frequency vs Current');
xlabel('Current (nA)');
ylabel('Frequency (Hz)');
