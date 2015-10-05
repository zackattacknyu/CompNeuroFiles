
numAngles = 1000;
halfRange = (9/10)*pi;

noiseWidth = 0;

%population size
popSize=4;
%popSize=12;

minFiringRate = 1;
maxFiringRate = 2;

[ xx,preferredAngles,maxRates ] = generatePopCodeParameters( ...
    numAngles,popSize,noiseWidth,minFiringRate,maxFiringRate );

[curves,error] = generatePopulationCodes(xx,maxRates,preferredAngles);


figure
hold on
for i = 1:popSize
   plot(xx,curves{i}); 
end
hold off

figure
plot(radtodeg(xx),radtodeg(error));

meanError = radtodeg(mean(error));
