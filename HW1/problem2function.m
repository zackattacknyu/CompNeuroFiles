function [ curves,error,meanError,xx,preferredAngles,maxRates ] = problem2function( numAngles,popSize,noiseWidth,minFiringRate,maxFiringRate )
%PROBLEM2FUNCTION This generates the population code parameters and then 
%                    generates the corresponding data
%
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
%
%   OUTPUT:
%       curves - the firing rate curves for each neuron
%       error - the error between direction using neurons and actual
%               direction for each angle in xx
%       meanError - mean error value

[ xx,preferredAngles,maxRates ] = generatePopCodeParameters( ...
    numAngles,popSize,noiseWidth,minFiringRate,maxFiringRate );
[curves,error,meanError] = generatePopulationCodes(...
    xx,maxRates,preferredAngles);


end

