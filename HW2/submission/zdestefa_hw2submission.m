function [ ] = zdestefa_hw2submission( )
%HW2SUBMISSION Summary of this function goes here
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%PART 1, THE GOLDMAN EQUATION PLOTS SUBMISSION
%

%{
This plots the membrane potential values using the Goldman equation.
When the permeability ratio is 0.02 (time steps 1-44 and 56-100), 
    the membrane potential is around -75.7 mV
When the permeability ratio is 20 (time steps 45-55), 
    the membrane potential increases to around 40.13 mV
%}
goldman;

%{
Out of curiousity, I also plotted b value versus Em
    to see what the curve looks like. It is a smooth
    log curve as expected
%}
goldman2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%PART 2, INTEGRATE AND FIRE NEURON SUBMISSION
%

%shows the frequency vs current in the 0-4 nA range
%   the neuron starts firing at 1.5 nA and the firing rate increases
%   rapidly at first, followed by increasing in a step-like manner
ifNeuronPlot( 0:0.05:4 );

%shows the frequency vs current in the 0-20 nA range
%   The firing rate increases in a step-like manner with the steps
%   growing larger and larger. At 16 nA, it reaches the maximal
%   firing rate of 2000 Hz that we can calculate
ifNeuronPlot( 0:.1:20 );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%PART 2, IZHIKEVICH NEURON SUBMISSION
%

%shows the firing rate in the 0-4 nA range
%   class 2 excitable neuron begins firing around 0.4 nA
%       and then starts firing quite quickly
%   the class 1 excitable neuron does not fire at all in this range
%   the regular spiking neuron barely starts firing in this range
izhevichPlots(0:0.01:4);

%shows the firing rate in the 0-20 nA range
%   The class 2 excitable neuron begins firing at a low current
%       and fires much faster as current increases than the others
%   The class 1 excitable neuron does not begin firing rate
%   The regular spiking neuron begins to fire
izhevichPlots(0:0.1:20);

%shows the firing rates in the 0-100 nA range
%   The class 2 excitable neuron reaches the maximal firing
%       rate of 2000 Hz measurable via our method after around 50 nA.
%   The class 1 excitable neuron does not firing until around 22 nA
%       and then increasing its firing rate relatively linearly
%   The regular spiking neuron starts firing with a current of around 3 nA
%       and increasing its firing rate linearly at first, then
%       increasing in a more step-like manner
izhevichPlots(0:1:100);

%shows the firing rates in the 0-800 nA range
%   after about 600 nA, all the neurons reach 
%   the maximal firing rate we can calculate
izhevichPlots(0:10:800);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%HELPER FUNCTIONS BELOW
%

function goldman

emVals = zeros(1,100);
for i = 1:100
   emVals(i) = getEm(0.02); 
end

for i = 45:55
   emVals(i) = getEm(20); 
end

figure
plot(1:100,emVals);
title('Membrane Potential during different time steps');
xlabel('Time Step');
ylabel('Membrane Potential (mV)');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ ] = goldman2( )
%GOLDMAN2 Plots b value versus Em

bVals = 0:0.02:20;
emVals = zeros(size(bVals));
for i = 1:length(bVals)
    emVals(i) = getEm(bVals(i));
end

figure
plot(bVals,emVals);
title('b value versus Em');
xlabel('Ratio of Sodium to Potassium Permeability (b value)');
ylabel('Membrane Potential (mV)');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ freqVals ] = getIzCurve( iVals,aa,bb,cc,dd )
%GETIZCURVE Takes in current values and parameters and finds the frequency
%vs current curve
%
%INPUT
%   iVals - array of current values in nA
%   aa, bb, cc, dd - a,b,c,d in Izhikevich model
%
%
%OUTPUT
%   freqVals - array of frequency values in Hz

%threshold voltage, from slide on Izhikevich model slide
Vth = 30; 

%after doing some testing, it took about 500 steps
%   when current was 0 for u and v to reach a steady state
numStepsToSteady=500;

%number of active time steps in one second since 
%   each time step is 1/2 ms
numTimeSteps=2000;

%find initial u and v values by iterating until steady state
%   no current is being injected here
curV = cc; curU = bb*cc; %initial guesses for u and v, from code
for t=0:numStepsToSteady
    curV = curV + (0.04*curV^2 + 5*curV + 140 - curU);
    curU = curU + aa*(bb*curV-curU);
    if(curV > Vth)
       curV = cc;
       curU = curU + dd;
    end
end
initU = curU;
initV = curV;

%Now that we have initial u and v values, find the number
%   of times the neurons fires in the span of 2000 time steps
%   in order to get the frequency in Hz for each value of current
freqVals = zeros(size(iVals));
for j = 1:length(iVals)
    curI = iVals(j);
    curV = initV;
    curU = initU;
    for t=0:numTimeSteps
        curV = curV + (0.04*curV^2 + 5*curV + 140 - curU + curI);
        curU = curU + aa*(bb*curV-curU);
        if(curV > Vth)
           curV = cc;
           curU = curU + dd;
           freqVals(j) = freqVals(j) + 1;
        end
    end
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function em = getEm(b)
%GETEM Calculates the goldman equation for different b values

    kPlusOut = 5;
    kPlusIn = 125;
    NaPlusOut = 120;
    NaPlusIn = 12;
    ClMinusIn = 5;
    ClMinusOut = 125;
    c=1;

    numer = kPlusOut + b*NaPlusOut + c*ClMinusIn;
    denom = kPlusIn + b*NaPlusIn + c*ClMinusOut;
    em = 58*log10(numer/denom);
    
end



end

