function [ curves,error ] = generatePopulationCodes( xx,maxRates,preferredAngles )
%GENERATEPOPULATIONCODES This is used to generate the population codes
%                        for the input angles in xx given the max firing
%                        rates and preferred firing rates inputted. The
%                        curves and error array are outputted. 
%
%   INPUT:
%       xx - input wind directions as angles in radians
%       maxRates - max firing rates for each of the neurons in population
%       preferredAngles - the preferred firing rates for each neuron in
%                           population
%
%
%   OUTPUT:
%       curves - the firing rate curves for each neuron
%       error - the error between direction using neurons and actual
%               direction for each angle in xx

popSize = length(maxRates);

%this generates the cosine tuning curves for each neuron
curves = cell(1,popSize);
for i = 1:popSize
    curCurve = maxRates(i).*cos(xx-preferredAngles(i)); 
    curCurve(curCurve<0)=0;
    curves{i} = curCurve;
end

%generate the vector for each tuning curve
%   I use complex numbers to represent the vectors
directionVectors = maxRates.*(exp(1i*preferredAngles));

%uses the magnitude of each tuning curve
%   to get the vector corresponding to each angle
angleVectors = zeros(size(xx));
for i = 1:popSize
    angleVectors = angleVectors + directionVectors(i)*curves{i};
end

%finds the angle from the tuning curve
anglesFromTuning = angle(angleVectors);

%computes the error
error = abs(anglesFromTuning-xx);

end

