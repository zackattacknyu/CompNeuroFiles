inputDirs = 0:0.01:pi;

outputVert = zeros(size(inputDirs));
outputHoriz = zeros(size(inputDirs));

neuronPrefDirs = [pi/4 pi/2 3*pi/4 pi];
neuronWeights = [50 50 50 50];
HtoVweight = -0.2;
VtoHweight = -0.2;

figure
hold on
for i = 1:length(neuronPrefDirs)
   curve = cos(inputDirs-neuronPrefDirs(i))*neuronWeights(i); 
   curve(curve<0)=0;
   plot(radtodeg(inputDirs),curve);
end
hold off
%%
for i = 1:length(inputDirs)
   [outH,outV] = getNeuralNetOutput(inputDirs(i),neuronPrefDirs,...
       neuronWeights,HtoVweight,VtoHweight);
   outputVert(i) = outV;
   outputHoriz(i) = outH;
end

figure
hold on
plot(radtodeg(inputDirs),outputVert,'r-');
plot(radtodeg(inputDirs),outputHoriz,'g-');
hold off
legend('Vertical Neuron Firing Rate','Horizontal Neuron Firing Rate');