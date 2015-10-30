%one neuron for left eye
%one neuron for right eye
%
%100 V1 neurons

%number of time steps
T=100;

rightNeuronInput = 5;
leftNeuronInput = 10;

numV1=100;
v1weightsR = rand(1,numV1); %weights for connections from right neuron
v1weightsL = rand(1,numV1); %weights for connections from left neuron

v1Out = zeros(T,numV1);
for t = 1:T
   for i = 1:numV1
      v1Out(t,i) = v1weightsR(i)*rightNeuronInput + v1weightsL(i)*leftNeuronInput; 
   end
end