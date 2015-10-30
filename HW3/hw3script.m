inputDirs = 0:0.01:pi;

%{
The following is the original architecutre with and without inhibtion
    and where the weights are all uniform, meaning the following:
INSERT DETAIL HERE

Results:
The horizontal output peaks around 180 degrees and the vertical output
    peaks near 90 degrees, which is what we would want to happen.
The inhibitary neurons do dampen the firing rates, but the dampening from
    the horizontal neuron is least severe at 90 degrees for the vertical
    neuron and vice versa.
Unfortunately, around 0 degrees, neither neuron outputs much whereas we
    want the horizontal neuron to have a high firing rate. This is occuring
    because the 180 degree neuron would have a zero firing rate near zero.
Because the inhibitory effect helps emphasize horizontal and vertical
    directions, I will keep the inhibtion for the further tests.
%}

neuronPrefDirs = [pi/4 pi/2 3*pi/4 pi];
neuronHorizWeights = [0 0 100 100];
neuronVertWeights = [100 100 0 0];


HtoVweight = -0.3;
VtoHweight = -0.3;

[outputHoriz,outputVert] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,0);
   
HtoVweight = 0;
VtoHweight = 0;

[outputHoriz1,outputVert1] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,0);

figure
hold on
plot(radtodeg(inputDirs),outputVert,'r-');
plot(radtodeg(inputDirs),outputHoriz,'g-');
plot(radtodeg(inputDirs),outputVert1,'r:');
plot(radtodeg(inputDirs),outputHoriz1,'g:');
xlabel('Angle in Degrees');
ylabel('Firing Rate');
title('Firing Rate Output with and without Inhibition');
hold off
legend('Vertical Neuron Firing Rate with Inhibition',...
    'Horizontal Neuron Firing Rate with Inhibition',...
    'Vertical Neuron Firing Rate without Inhibition',...
    'Horizontal Neuron Firing Rate without Inhibition',...
    'Location','eastoutside');



%{
The following is the original architecture with inhibition and there are
    two versions shown: with skewed weights and with uniform weights. The
    skewed weights version is meant to show
INSERT DETAIL HERE

Results:
Mostly the same as the previous one except that the difference between the max 
    and min firing rates have increased and the curves have seemingly
    become narrower. 
The increase in the difference further helps distinguish horizontal and
    vertical directions, thus for the next one, I will keep the skewed
    weights
%}

neuronPrefDirs = [pi/4 pi/2 3*pi/4 pi];
HtoVweight = -0.3;
VtoHweight = -0.3;

neuronHorizWeights = [0 0 100 100];
neuronVertWeights = [100 100 0 0];

[outputHoriz,outputVert] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,0);

neuronHorizWeights = [0 0 70 100];
neuronVertWeights = [70 100 0 0];

[outputHoriz1,outputVert1] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,0);
   
neuronHorizWeights = [0 0 40 100];
neuronVertWeights = [40 100 0 0];

[outputHoriz2,outputVert2] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,0);
   


figure
hold on
plot(radtodeg(inputDirs),outputVert,'r-');
plot(radtodeg(inputDirs),outputHoriz,'g-');
plot(radtodeg(inputDirs),outputVert1,'r:');
plot(radtodeg(inputDirs),outputHoriz1,'g:');
plot(radtodeg(inputDirs),outputVert2,'r--');
plot(radtodeg(inputDirs),outputHoriz2,'g--');
xlabel('Angle in Degrees');
ylabel('Firing Rate');
title('Firing Rate Output with and without skewed weights');
hold off
legend('Vertical Neuron Firing Rate without skewed weights',...
    'Horizontal Neuron Firing Rate without skewed weights',...
    'Vertical Neuron Firing Rate with skewed weights',...
    'Horizontal Neuron Firing Rate with skewed weights',...
    'Vertical Neuron Firing Rate with very skewed weights',...
    'Horizontal Neuron Firing Rate with very skewed weights',...
    'Location','eastoutside');

%{
This compares the old and new architecture
INSERT DETAIL HERE

Results:
%}

neuronPrefDirs = [pi/4 pi/2 3*pi/4 pi];
HtoVweight = -0.3;
VtoHweight = -0.3;

neuronHorizWeights = [0 0 40 100];
neuronVertWeights = [40 100 0 0];

[outputHoriz,outputVert] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,0);

neuronHorizWeights = [20 0 20 100];
neuronVertWeights = [20 100 20 0];

[outputHoriz1,outputVert1] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,0);
   

figure
hold on
plot(radtodeg(inputDirs),outputVert,'r-');
plot(radtodeg(inputDirs),outputHoriz,'g-');
plot(radtodeg(inputDirs),outputVert1,'r:');
plot(radtodeg(inputDirs),outputHoriz1,'g:');
xlabel('Angle in Degrees');
ylabel('Firing Rate');
title('Firing Rate Output with old and new arch');
hold off
legend('Vertical Neuron Firing Rate with old arch',...
    'Horizontal Neuron Firing Rate with old arch',...
    'Vertical Neuron Firing Rate with new arch',...
    'Horizontal Neuron Firing Rate with new arch',...
    'Location','eastoutside');


%{
This compares the old and new functions
INSERT DETAIL HERE

Results:
%}

neuronPrefDirs = [pi/4 pi/2 3*pi/4 pi];
HtoVweight = -0.3;
VtoHweight = -0.3;

neuronHorizWeights = [40 0 40 100];
neuronVertWeights = [40 100 40 0];

[outputHoriz,outputVert] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,0);

[outputHoriz1,outputVert1] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,1);
   

figure
hold on
plot(radtodeg(inputDirs),outputVert,'r-');
plot(radtodeg(inputDirs),outputHoriz,'g-');
plot(radtodeg(inputDirs),outputVert1,'r:');
plot(radtodeg(inputDirs),outputHoriz1,'g:');
xlabel('Angle in Degrees');
ylabel('Firing Rate');
title('Firing Rate Output with old and new function');
hold off
legend('Vertical Neuron Firing Rate with old function',...
    'Horizontal Neuron Firing Rate with old function',...
    'Vertical Neuron Firing Rate with new function',...
    'Horizontal Neuron Firing Rate with new function',...
    'Location','eastoutside');
