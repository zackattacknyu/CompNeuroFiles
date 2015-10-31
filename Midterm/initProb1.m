%one neuron for left eye
%one neuron for right eye
%
%100 V1 neurons

%using the synaptic normalization rule
%slide 16 of his 10-20 lecture notes


%number of time steps
T=100;

rightNeuronInput = rand(1,1)*2*pi;
leftNeuronInput = rand(1,1)*2*pi;

rightNeuronPref = pi;
leftNeuronPref = pi/2;

numV1=100;
v1weightsR = zeros(T+1,numV1); %weights for connections from right neuron
v1weightsL = zeros(T+1,numV1); %weights for connections from left neuron

GAIN=0.03;

maxWeight=50;

v1weightsR(1,:) = rand(1,numV1)*maxWeight;
v1weightsL(1,:) = rand(1,numV1)*maxWeight;

TAUW = 0.3; %learning rate

%inputRight = cosTune(rightNeuronPref,rightNeuronInput);
%inputLeft = cosTune(leftNeuronPref,leftNeuronInput);

inputRight = 1;
inputLeft = 0;

avgInput = mean([inputRight inputLeft]);
inputRFactor = (inputRight-avgInput)/TAUW;
inputLFactor = (inputLeft-avgInput)/TAUW;

odFactor = zeros(1,numV1);

v1Out = zeros(T,numV1);
for t = 1:T
   for i = 1:numV1 
       rightWeight = v1weightsR(t,i);
       leftWeight = v1weightsL(t,i);
       
       rightResponse = rightWeight*inputRight;
       leftResponse = leftWeight*inputLeft;
       
       synIn =  rightResponse+leftResponse;
       
       RER = sigmoidN(rightResponse,GAIN);
       LER = sigmoidN(leftResponse,GAIN);
       
       odFactor(i) = (RER-LER)/(RER+LER);
       output = sigmoidN(synIn,GAIN);
       %synIn
       v1Out(t,i) = output;
       
       %HEBB RULE HERE
       deltaWeightR = output*inputRFactor;
       deltaWeightL = output*inputLFactor;
       v1weightsR(t+1,i) = rightWeight + deltaWeightR;
       v1weightsL(t+1,i) = leftWeight + deltaWeightL;
   end
end
%%

hist(odFactor,5);


%%
figure
hold on
plot(v1weightsL(:,50));
plot(v1weightsR(:,25));
plot(v1weightsL(:,20));
hold off

%%
figure
hold on
plot(v1Out(:,50));
plot(v1Out(:,25));
plot(v1Out(:,20));
hold off

%%

figure
xx = 1:100;
g = 0.02;
powerVals = xx.*-g;
denomVals = 1 + exp(powerVals);
r = 1./denomVals;
plot(xx,r);