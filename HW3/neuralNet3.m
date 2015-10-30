<<<<<<< HEAD
inputDirs = 0:0.01:pi;


neuronPrefDirs = [pi/4 pi/2 3*pi/4 pi];
neuronHorizWeights = [50 0 50 100];
neuronVertWeights = [50 100 50 0];
HtoVweight = -0.5;
VtoHweight = -0.5;

[outputHoriz,outputVert] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight);
   
HtoVweight = 0;
VtoHweight = 0;

[outputHoriz1,outputVert1] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight);

figure
hold on
plot(radtodeg(inputDirs),outputVert,'r-');
plot(radtodeg(inputDirs),outputHoriz,'g-');
plot(radtodeg(inputDirs),outputVert1,'r:');
plot(radtodeg(inputDirs),outputHoriz1,'g:');
xlabel('Angle in Degrees');
ylabel('Firing Rate');
title('Firing Rate with Inhibition');
hold off
legend('Vertical Neuron Firing Rate','Horizontal Neuron Firing Rate',...
    'Vertical Neuron Firing Rate without Inhibition',...
    'Horizontal Neuron Firing Rate without Inhibition',...
=======
inputDirs = 0:0.01:pi;


neuronPrefDirs = [pi/4 pi/2 3*pi/4 pi];
neuronHorizWeights = [50 0 50 100];
neuronVertWeights = [50 100 50 0];
HtoVweight = -0.5;
VtoHweight = -0.5;

[outputHoriz,outputVert] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight);
   
HtoVweight = 0;
VtoHweight = 0;

[outputHoriz1,outputVert1] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight);

figure
hold on
plot(radtodeg(inputDirs),outputVert,'r-');
plot(radtodeg(inputDirs),outputHoriz,'g-');
plot(radtodeg(inputDirs),outputVert1,'r:');
plot(radtodeg(inputDirs),outputHoriz1,'g:');
xlabel('Angle in Degrees');
ylabel('Firing Rate');
title('Firing Rate with Inhibition');
hold off
legend('Vertical Neuron Firing Rate','Horizontal Neuron Firing Rate',...
    'Vertical Neuron Firing Rate without Inhibition',...
    'Horizontal Neuron Firing Rate without Inhibition',...
>>>>>>> origin/master
    'Location','eastoutside');