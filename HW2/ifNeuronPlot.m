function [ ] = ifNeuronPlot( iVals )
%IFNEURONPLOT Generates the Integrate and Fire Neuron FI plot
%
%Takes in an array of current values and generates
%   the plot of frequency vs current for the Integrate and Fire neuron

%parameter values from figure 5.5
V0 = -65;
Rm = 10;
EL = V0;
Vth = -50;
tauM = 10;

%number of time steps in one second
numTimeSteps=2000;

%calculates the frequency for each current value
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

%plots frequency vs current
figure
plot(iVals,freqVals);
title('Frequency vs Current');
xlabel('Current (nA)');
ylabel('Frequency (Hz)');



end

