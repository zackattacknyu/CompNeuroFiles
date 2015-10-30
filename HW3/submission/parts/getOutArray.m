function [ outputHoriz,outputVert ] = getOutArray( inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,spflag )
%GETOUTARRAY Gets the horizontal and vertical output for each
%           input direction angle in inputDirs

outputVert = zeros(size(inputDirs));
outputHoriz = zeros(size(inputDirs));

for i = 1:length(inputDirs)
   [outH,outV] = getNeuralNetOut(inputDirs(i),neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,spflag);
   outputVert(i) = outV;
   outputHoriz(i) = outH;
end
    
end

