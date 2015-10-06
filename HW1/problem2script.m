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

[~,~,meanError1] = problem2function(...
    numAngles,popSize,noiseWidth,minFiringRate,maxFiringRate );

meanError1

%increases the population size to 8
popSize=8;
[~,~,meanError2] = problem2function(...
    numAngles,popSize,noiseWidth,minFiringRate,maxFiringRate );

meanError2

popSize=16;
[~,~,meanError3] = problem2function(...
    numAngles,popSize,noiseWidth,minFiringRate,maxFiringRate );

meanError3

popSize=32;
[~,~,meanError4] = problem2function(...
    numAngles,popSize,noiseWidth,minFiringRate,maxFiringRate );

meanError4

%{
The above 4 mean errors were all around 1e-15, so negligable
    in floating point terms, when I ran the script
%}

%%
%{
When the preferred angles are all evenly spaced, but the firing
    rate varies, **FILL IN WHAT HAPPENS**
%}
minFiringRate = 1;
maxFiringRate = 2;
popSize=4;

[curves,error,meanError5,xx,preferredAngles,maxRates] = ...
    problem2function(numAngles,popSize,noiseWidth,...
    minFiringRate,maxFiringRate );

graphPopulationCodes(xx,curves,preferredAngles,maxRates);
graphErrors(xx,error);


