
numAngles = 1000;

noiseWidth = 0;

%population size
popSize=8;
%popSize=12;

minFiringRate = 1;
maxFiringRate = 1;

[ xx,preferredAngles,maxRates ] = generatePopCodeParameters( ...
    numAngles,popSize,noiseWidth,minFiringRate,maxFiringRate );

[curves,error] = generatePopulationCodes(xx,maxRates,preferredAngles);


figure
hold on
for i = 1:popSize
   plot(xx,curves{i}); 
end
xlabel('Wind Direction (degrees)');
ylabel('Neuron Firing Rate (Hz)');
hold off

figure
plot(radtodeg(xx),radtodeg(error));
xlabel('Wind Direction (degrees)');
ylabel('Error (Degrees)');

meanError = radtodeg(mean(error));
