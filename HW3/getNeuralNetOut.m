function [ horizNeuronOutput,vertNeuronOutput ] = getNeuralNetOut( ...
    inputDir, neuronPrefDirs,neuronHorizWeights, neuronVertWeights,...
    horizToVertInhib, vertToHorizInhib, spflag  )
%GETNEURALNETOUTPUT Summary of this function goes here
%   Detailed explanation goes here

%{
This is the neural network:

Neuron1 (tune to 45 deg)  -> HorizNeuron & VertNeuron
Neuron2 (tune to 90 deg   -> HorizNeuron & VertNeuron
Neuron3 (tune to 135 deg) -> HorizNeuron & VertNeuron
Neuron4 (tune to 180 deg) -> HorizNeuron & VertNeuron

Inhibition between VertNeuron and HorizNeuron

%}

horizNeuronExcit = zeros(1,4);
vertNeuronExcit = zeros(1,4);
for i = 1:4
   horizNeuronExcit(i) = getFeedForwardOutput(inputDir,...
       neuronPrefDirs(i),neuronHorizWeights(i),spflag); 
   vertNeuronExcit(i) = getFeedForwardOutput(inputDir,...
       neuronPrefDirs(i),neuronVertWeights(i),spflag); 
end

vertNeuronExcitation = sum(vertNeuronExcit);
horizNeuronExcitation = sum(horizNeuronExcit);


vertNeuronOutput = vertNeuronExcitation + ...
    horizToVertInhib*horizNeuronExcitation;
horizNeuronOutput = horizNeuronExcitation + ...
    vertToHorizInhib*vertNeuronExcitation;


end

