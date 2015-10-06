function [ xx,preferredAngles,maxRates ] = generatePopCodeParameters( ...
    numAngles,popSize,noiseWidth,minFiringRate,maxFiringRate )
%GENERATEPOPCODEPARAMETERS This generates the parameters used when
%                          calculating the population codes
%   
%   INPUT
%       numAngles - number of angles in range -0.95*pi to 0.95*pi
%                   to use when calculating population code direction versus 
%                   real direction
%       popSize - number of neurons in the population
%       noiseWidth - the neuron preferred directions are initially 
%                    evenly spaced between -pi and pi. They are then
%                    randomly offset using a number in the range 
%                    -epsilon to epsilon with epsilon determined by this
%                    parameter
%       minFiringRate & maxFiringRate - the firing rates for each neuron
%                    are randomly distributed numbers whose range is
%                    determined by these numbers

halfRange = (0.85)*pi;

%generates the input angles
xxInit = rand(1,numAngles).*2*halfRange - halfRange;
xx = sort(xxInit);

%initial preferred neuron directions
initAngles = linspace(-pi,pi,popSize+1);

%prefereed neuron directions after adding noise
preferredAngles = initAngles(1:popSize)+...
    rand(1,popSize)*2*noiseWidth - noiseWidth;

%generate the firing rates
maxRates = rand(1,popSize)*(maxFiringRate-minFiringRate)+...
    minFiringRate;


end

