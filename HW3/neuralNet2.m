inputDirs = 0:0.01:pi;

outputVert = zeros(size(inputDirs));
outputHoriz = zeros(size(inputDirs));

for i = 1:length(inputDirs)
   [outH,outV] = getNeuralNetOutput(inputDirs(i));
   outputVert(i) = outV;
   outputHoriz(i) = outH;
end

figure
hold on
plot(radtodeg(inputDirs),outputVert,'r-');
plot(radtodeg(inputDirs),outputHoriz,'g-');
hold off
legend('Vertical Neuron Firing Rate','Horizontal Neuron Firing Rate');