neuronPrefDirs = (pi/4).*[1 2 3 4];

neuronOutputs = zeros(1,4);

inputDir = pi*rand(1,1);

for i = 1:4
    neuronOutputs(i) = max(0,cos(neuronPrefDirs(i)-inputDir));
end

horizWeight1 = neuronOutputs(1)+neuronOutputs(2);
vertWeight1 = neuronOutputs(3)+neuronOutputs(4);

synapseHoriz = 0.5*rand(1,1);
synapseVert = 0.4*rand(1,1);

horizWeight = horizWeight1 - synapseHoriz;
vertWeight = vertWeight1 - synapseVert;

outputDir = angle(horizWeight + 1i*vertWeight);