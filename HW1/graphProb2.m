
numPoints = 1000;
halfRange = (9/10)*pi;

noiseWidth = pi/18;

%population size
popSize=4;
%popSize=12;

minFiringRate = 1;
maxFiringRate = 2;

xxInit = rand(1,numPoints).*2*halfRange - halfRange;
xx = sort(xxInit);

initAngles = linspace(-pi,pi,popSize+1);

preferredAngles = initAngles(1:popSize)+...
    rand(1,popSize)*2*noiseWidth - noiseWidth;

maxRates = rand(1,popSize)*(maxFiringRate-minFiringRate)+...
    minFiringRate;

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
