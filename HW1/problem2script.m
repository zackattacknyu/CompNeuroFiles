
numAngles = 100;
noiseWidth = 0;

%population size
popSize=4;
%popSize=12;

minFiringRate = 1;
maxFiringRate = 1;

[ xx,preferredAngles,maxRates ] = generatePopCodeParameters( ...
    numAngles,popSize,noiseWidth,minFiringRate,maxFiringRate );

[curves,error] = generatePopulationCodes(xx,maxRates,preferredAngles);
%%
graphPopulationCodes(xx,curves,preferredAngles,maxRates);
%%
graphErrors(xx,error);

meanError = radtodeg(mean(error));
