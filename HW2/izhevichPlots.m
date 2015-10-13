function [ ] = izhevichPlots( iVals )
%IZHEVICHPLOTS Generates the Izhevich plots depending on current values
%
%Takes in an array of current values and generates
%   the plot of frequency vs current for the Izhevich models

%Class 1 Excitable parameters
aa = 0.02;
bb = -0.1;
cc = -55;
dd = 6;
freqValsA = getIzCurve(iVals,aa,bb,cc,dd);

%Class 2 Excitable parameters
aa = 0.2;
bb = 0.26;
cc = -65;
dd = 0;
freqValsB = getIzCurve(iVals,aa,bb,cc,dd);

%Regular spiking neuron parameters
aa = 0.02;
bb = 0.2;
cc = -65;
dd = 8;
freqValsC = getIzCurve(iVals,aa,bb,cc,dd);

%plots for the frequency vs current curve
%   for each of the above models
figure
hold on
plot(iVals,freqValsA,'r-');
plot(iVals,freqValsB,'g-');
plot(iVals,freqValsC,'b-');
hold off
legend('Class 1 Excitble',...
    'Class 2 Excitable',...
    'Regular Spiking Neuron',...
    'Location','eastoutside');
title('Frequency vs Current');
xlabel('Current (nA)');
ylabel('Frequency (Hz)');

end

