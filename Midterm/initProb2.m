%100 CA3 neurons
%1 CA1 neuron connected to it

numCA3 = 100;

%weights of CA3 to CA1 connections
synWeights = ones(1,numCA3);

%100 CA3 neurons and their place field center
ca3neuronCenter = 1:numCA3;

%1 CA1 neuron center
ca1neuronCenter = numCA3/2;

ratPositions=0:0.01:100;
numT = length(ratPositions);

ca3out = zeros(numT,numCA3);

ca1out = zeros(numT,1);

for i=1:length(ratPositions)
   
    xx = ratPositions(i);
    
    curSynIn = zeros(1,numCA3);
    for j = 1:numCA3
       curSynIn(j) = synWeights(j)*normpdf(xx,ca3neuronCenter(j),1); 
    end
    
    curCa1In = normpdf(xx,ca1neuronCenter);
    
    ca1out(i) = sum(curSynIn)+curCa1In;
    
end