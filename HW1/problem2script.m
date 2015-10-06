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
    rate varies, there is some error. It seems to be minimized
    at the preferred directions of the neurons
%}
minFiringRate = 1;
maxFiringRate = 2;
popSize=4;

[curves,error,meanError5,xx,preferredAngles,maxRates] = ...
    problem2function(numAngles,popSize,noiseWidth,...
    minFiringRate,maxFiringRate );

graphPopulationCodes(xx,curves,preferredAngles,maxRates);
graphErrors(xx,error);

meanError5

popSize=8;

[curves,error,meanError6,xx,preferredAngles,maxRates] = ...
    problem2function(numAngles,popSize,noiseWidth,...
    minFiringRate,maxFiringRate );

graphPopulationCodes(xx,curves,preferredAngles,maxRates);
graphErrors(xx,error);

meanError6

popSize=16;
[~,~,meanError7] = ...
    problem2function(numAngles,popSize,noiseWidth,...
    minFiringRate,maxFiringRate );
meanError7

popSize=32;
[~,~,meanError8] = ...
    problem2function(numAngles,popSize,noiseWidth,...
    minFiringRate,maxFiringRate );
meanError8
%%
popSize=64;
means = zeros(1,100);
for jj=1:1000
    [~,~,means(jj)] = ...
        problem2function(numAngles,popSize,noiseWidth,...
        minFiringRate,maxFiringRate );
end
mean(means)

