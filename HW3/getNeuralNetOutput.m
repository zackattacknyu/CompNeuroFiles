function [ horizNeuronOutput,vertNeuronOutput ] = getNeuralNetOutput( inputDir )
%GETNEURALNETOUTPUT Summary of this function goes here
%   Detailed explanation goes here

%{
This is the neural network:

Neuron1 (tune to 45 deg)  -> VertNeuron
Neuron2 (tune to 90 deg   -> VertNeuron

Neuron3 (tune to 135 deg) -> HorizNeuron
Neuron4 (tune to 180 deg) -> HorizNeuron

Inhibition between VertNeuron and HorizNeuron

%}

neuronPrefDirs = [pi/4 pi/2 3*pi/4 pi];
neuronWeights = [50 100 50 100];

%inputDir = pi*rand(1,1);

neuronInitOutput = zeros(1,4);
for i = 1:4
    neuronInitOutput(i) = max(0,cos(neuronPrefDirs(i)-inputDir))*neuronWeights(i);
end

vertNeuronInitOutput = neuronInitOutput(1)+neuronInitOutput(2);
horizNeuronInitOutput = neuronInitOutput(3)+neuronInitOutput(4);

horizToVertWeight = -0.15;
vertToHorizWeight = -0.15;

vertNeuronOutput = vertNeuronInitOutput + horizToVertWeight*horizNeuronInitOutput;
horizNeuronOutput = horizNeuronInitOutput + vertToHorizWeight*vertNeuronInitOutput;


end

