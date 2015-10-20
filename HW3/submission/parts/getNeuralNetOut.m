function [ horizNeuronOutput,vertNeuronOutput ] = getNeuralNetOut( ...
    inputDir, neuronPrefDirs,neuronHorizWeights, neuronVertWeights,...
    horizToVertInhib, vertToHorizInhib, spflag  )
%GETNEURALNETOUTPUT Gets the horizontal and vertical neuron output
%       given the network parameters and input

%{
Assumes the network is structured as follows:
    neurons whose preferred directions are in neuronPrefDirs
    Each of those neurons sends to a horizontal and vertical output
        neuron via a weight specified in the parameters
    The horizontal and vertical neurons send inhibitory signals to each
        other
%}


%this calculates the initial feed-forward excitation of the input neurons
%   we now have the contribution of those input neurons to the horizontal
%       and vertical neurons
horizNeuronExcit = zeros(1,4);
vertNeuronExcit = zeros(1,4);
for i = 1:length(neuronPrefDirs);
   horizNeuronExcit(i) = getFeedForwardOutput(inputDir,...
       neuronPrefDirs(i),neuronHorizWeights(i),spflag); 
   vertNeuronExcit(i) = getFeedForwardOutput(inputDir,...
       neuronPrefDirs(i),neuronVertWeights(i),spflag); 
end
vertNeuronExcitation = sum(vertNeuronExcit);
horizNeuronExcitation = sum(horizNeuronExcit);

%this calculates the final vertical and horizontal output
%   it is the excitation minus the inhibition from the other neuron
vertNeuronOutput = vertNeuronExcitation + ...
    horizToVertInhib*horizNeuronExcitation;
horizNeuronOutput = horizNeuronExcitation + ...
    vertToHorizInhib*vertNeuronExcitation;


end

