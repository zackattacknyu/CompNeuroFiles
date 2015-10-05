
numPoints = 100;

xxInit = rand(1,numPoints).*2*pi - pi;
xx = sort(xxInit);

%population size
%popSize=4;
popSize=12;

initAngles = linspace(-pi,pi,popSize+1);
noiseWidth = 0;
preferredAngles = initAngles(1:popSize)+rand(1,popSize)*2*noiseWidth - noiseWidth;

maxRates = rand(1,popSize)+1;
curves = cell(1,popSize);
for i = 1:popSize
    curCurve = maxRates(i).*cos(xx-preferredAngles(i)); 
    curCurve(curCurve<0)=0;
    curves{i} = curCurve;
end

figure
hold on
for i = 1:popSize
   plot(xx,curves{i}); 
end
hold off

directionVectors = maxRates.*(exp(1i*preferredAngles));

angleVectors = zeros(size(xx));
for i = 1:popSize
    angleVectors = angleVectors + directionVectors(i)*curves{i};
end

anglesFromTuning = angle(angleVectors);

error = abs(anglesFromTuning-xx);
figure
plot(radtodeg(xx),radtodeg(error));
