function [  ] = graphPopulationCodes( xx,curves,preferredAngles,maxRates )
%GRAPHPOPULATIONCODES This graphs the firing rates for each neuron
%                       in a population code
%   
%   INPUT
%       xx - input angles
%       curves - firing rate curves for each neuron
%       preferredAngles - preferred angles for each neuron
%       maxRates - max firing rates for each neuron

popSize = length(preferredAngles);

figure
colors = {'r','g','b','k'};
lines = {'-',':','--'};
legendEntries = cell(1,popSize);
hold on
for i = 1:popSize
    colorInd = mod(i,4)+1;
    lineInd = mod(i,3)+1;
    displayAngle = num2str(radtodeg(preferredAngles(i)));
    displayRate = num2str(maxRates(i));
    plot(radtodeg(xx),curves{i},[colors{colorInd} lines{lineInd}]); 
    legendEntries{i} = strcat('Angle: ',displayAngle,';Max Rate:',displayRate);
end
legend(legendEntries);
title('Firing Rate for different neurons as function of wind direction');
xlabel('Wind Direction (degrees)');
ylabel('Neuron Firing Rate (Hz)');
hold off

end

