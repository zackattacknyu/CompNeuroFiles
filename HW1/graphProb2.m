
numPoints = 100;
%xx = -179:1:179;
xxInit = rand(1,numPoints).*2*pi - pi;
xx = sort(xxInit);

%population size
popSize=4;

initAngles = linspace(0,2*pi,popSize+1);
noiseWidth = pi/18;
preferredAngles = initAngles(1:popSize)+rand(1,popSize)*2*noiseWidth - noiseWidth;

figure
hold on
maxRates = rand(1,popSize)+1;
curves = cell(1,popSize);
for i = 1:popSize
    curCurve = maxRates(i).*cos(xx-preferredAngles(i)); 
    curCurve(curCurve<0)=0;
    curves{i} = curCurve;
    plot(xx,curCurve);
end
hold off
%%

directionVectors = cell(1,popSize);
c1 = mag1*1;
c2 = mag2*1i;
c3 = mag3*-1;
c4 = mag4*-1i;

dirVecs = c1*curve1 + c2*curve2 + c3*curve3 + c4*curve4;
%%

dirs = radtodeg(angle(dirVecs));
%%
error = abs(dirs-xx);
plot(xx,error);
%%plot(dirs);

%%
