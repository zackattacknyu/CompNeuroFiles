function [  ] = zdestefa_midtermProb1(  )

%{
This is my code for problem 1.
We had neurons for the left and right eye and each neuron
    was connected to 100 v1 neurons
The strength of these neurons was initialized to be random numbers 
    and then we used the Hebbian plasticity rule to update the strengths

To simulate the firings, I used a mean firing rate network heavily inspired
    by jk_hw3_miniNet.m 
To update the weights due to plasticity, the plasiticty rule used was 
    the Hebbian rule in slide 16 of the 10-20 lecture notes. 
    This one allowed for normalization, hence why I used it.

I decided that the input if the eyes are open would be a constant value and
    0 if the eyes are closed. This is done as a simplifying assumption,
    because while what the kitten sees will change, there will be input
    coming in from an open eye, so a constant value will ensure that the
    open eye is being considered in each time step. Additionally, we are
    modeling the difference between eyes being open and shut, rather than
    the specific inputs to an eye, so it makes sense to simplify what the
    eye sees and put the complications into the network itself. 
Finally, by making sure open eyes have a constant value and closed eyes have a
    value of 0, the difference in OD factors will become more pronounced
    than if open eyes had random input values. 
%}


%{
As an initial case, both kitten's eyes are open, so it gets an equal stream of
    input from both eyes.
%}
inputRight = 1;
inputLeft = 1;

%this runs the model and obtains the OD factors
odFactor = getODfactors(inputRight,inputLeft);

%{
This is the OD factor graph for when the kitten has both eyes open.
It should be a relatively uniform histogram.
%}
figure
hist(odFactor,5);
title('Both eyes open OD factor graph');
ylabel('Number of Neurons');
xlabel('OD Range');

%{
The left eye is sutured shut, so its input is 0 while the right eye
    has a constant stream of input of 1
%}
inputRight = 1;
inputLeft = 0;

odFactor = getODfactors(inputRight,inputLeft);

%{
This is the OD factor graph for when the kitten has the left eye shut
Most of the values should thus be on the right side
%}
figure
hist(odFactor,5);
title('Left eye sutured OD factor graph');
ylabel('Number of Neurons');
xlabel('OD Range');

%{
The right eye is sutured shut, so its input is 0 while the left eye
    has a constant stream of input of 1
%}
inputRight = 0;
inputLeft = 1;

odFactor = getODfactors(inputRight,inputLeft);

%{
This is the OD factor graph for when the kitten has the right eye shut
    thus most of the values should be on the left side
%}
figure
hist(odFactor,5);
title('Right eye sutured OD factor graph');
ylabel('Number of Neurons');
xlabel('OD Range');

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
       
       %use the Hebbian plasticity rule
       %    to update the weights of the connection from the 
       %    right and left eye to this neuron
       deltaWeightR = output*inputRFactor;
       deltaWeightL = output*inputLFactor;
       v1weightsR(t+1,i) = rightWeight + deltaWeightR;
       v1weightsL(t+1,i) = leftWeight + deltaWeightL;
   end
end

end

% Sigmoid Activation
%   Input:  I - synaptic input
%           g - gain
%   Output: firing rate of sigmoid function
function r = sigmoidN (I, g) 
r = 1/(1+exp(-g*I));
end


end

