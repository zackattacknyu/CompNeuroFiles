%This is the script for problem 2

%{
When the preferred angles are evenly spaced,
    and the firing rates are all constant, the error
    ends up near zero
%}
numAngles = 100; %number of test angles
noiseWidth = 0; %variance in preferred angles
popSize=4; %number of neurons

%firing rate range
minFiringRate = 1;
maxFiringRate = 1;

[ xx,preferredAngles,maxRates ] = generatePopCodeParameters( ...
    numAngles,popSize,noiseWidth,minFiringRate,maxFiringRate );
[curves,error] = generatePopulationCodes(xx,maxRates,preferredAngles);


meanError = radtodeg(mean(error));

graphPopulationCodes(xx,curves,preferredAngles,maxRates);

graphErrors(xx,error);


