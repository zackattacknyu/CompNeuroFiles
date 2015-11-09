function [ odFactor ] = getODfactors( inputRight,inputLeft )

%This runs the model for problem 1

%number of time steps
T=100;

%number of V1 neurons
numV1=100;

%{
This will be used to keep track of the weights of the connections
    from the right/left neuron to all the V1 neurons
%}
v1weightsR = zeros(T+1,numV1); 
v1weightsL = zeros(T+1,numV1); 

%gain used when calculating the sigmoid response
GAIN=0.03;

%{
This initializes all the synaptic connection strengths to uniformly
    distributed random values between 0 and 50;
%}
maxWeight=50;
v1weightsR(1,:) = rand(1,numV1)*maxWeight;
v1weightsL(1,:) = rand(1,numV1)*maxWeight;

TAUW = 0.3; %learning rate in the Hebbian plasticity model

%factors used when calculating change in weights according
%   to the Hebb rule
avgInput = mean([inputRight inputLeft]);
inputRFactor = (inputRight-avgInput)/TAUW;
inputLFactor = (inputLeft-avgInput)/TAUW;

%keeps track of OD factor for each of the V1 neurons
odFactor = zeros(1,numV1);

for t = 1:T %go through each time step
    
   for i = 1:numV1 %go through each V1 neuron
       
       %weights from right and left eye for this v1 neuron
       rightWeight = v1weightsR(t,i);
       leftWeight = v1weightsL(t,i);
       
       %response from right and left eye neuron going into this v1 neuron
       rightResponse = rightWeight*inputRight;
       leftResponse = leftWeight*inputLeft;
       
       %total input into the synapse
       synIn =  rightResponse+leftResponse;
       
       %calculates the occular dominance factor
       RER = sigmoidN(rightResponse,GAIN);
       LER = sigmoidN(leftResponse,GAIN);
       odFactor(i) = (RER-LER)/(RER+LER);
       
       %calculates the output of the v1 neuron
       output = sigmoidN(synIn,GAIN);
       
       %I use the Hebbian plasticity rule
       %    to update the weights of the connection from the 
       %    right and left eye to this neuron
       deltaWeightR = output*inputRFactor;
       deltaWeightL = output*inputLFactor;
       v1weightsR(t+1,i) = rightWeight + deltaWeightR;
       v1weightsL(t+1,i) = leftWeight + deltaWeightL;
   end
end

end

