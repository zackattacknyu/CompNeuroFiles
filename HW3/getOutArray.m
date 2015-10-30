<<<<<<< HEAD
function [ outputHoriz,outputVert ] = getOutArray( inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,spflag )
%GETOUTARRAY Summary of this function goes here
%   Detailed explanation goes here

outputVert = zeros(size(inputDirs));
outputHoriz = zeros(size(inputDirs));

    for i = 1:length(inputDirs)
       [outH,outV] = getNeuralNetOut(inputDirs(i),neuronPrefDirs,...
           neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,spflag);
       outputVert(i) = outV;
       outputHoriz(i) = outH;
    end
    
end

=======
function [ outputHoriz,outputVert ] = getOutArray( inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,spflag )
%GETOUTARRAY Summary of this function goes here
%   Detailed explanation goes here

outputVert = zeros(size(inputDirs));
outputHoriz = zeros(size(inputDirs));

    for i = 1:length(inputDirs)
       [outH,outV] = getNeuralNetOut(inputDirs(i),neuronPrefDirs,...
           neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,spflag);
       outputVert(i) = outV;
       outputHoriz(i) = outH;
    end
    
end

>>>>>>> origin/master
