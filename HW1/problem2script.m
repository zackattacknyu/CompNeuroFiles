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

%{
When I ran the above part, this was the result:

meanError5=7.1 
meanError6=4.4

Figure 1 shows the population code graph for 4 neurons
Figure 2 shows the graph of direction vs angle error for 4 neurons

Figure 3 shows the population code graph for 8 neurons
Figure 4 shows the graph of direction vs angle error for 8 neurons

The error seems to decrease as we increase the number of neurons.
The below blocks prove that out more
%}

%%

%{
Here I ran multiple trials for each population size case
    to see the impact of population size on angle error
%}
numTrials = 1000;
popSizes = [4 8 12 16 20 32 64 128];
meanByPopSize = zeros(size(popSizes));
for sizeNum=1:length(popSizes)
    popSize = popSizes(sizeNum);
    means = zeros(1,numTrials);
   for jj = 1:numTrials
    [~,~,means(jj)] = ...
        problem2function(numAngles,popSize,noiseWidth,...
        minFiringRate,maxFiringRate );
   end
   meanByPopSize(sizeNum) = mean(means);
end
meanByPopSize
%{
When I ran the script, I obtained the following values:
#Neurons:      4       8      12     16     20     32     64    128
meanByPopSize: 8.5    6.3    5.1    4.3    3.9    3.0    2.2    1.5

Thus, as we increase the number of neurons, the average error does decrease
%}


