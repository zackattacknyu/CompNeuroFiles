function [ ] = zdestefa_hw3submission( )

%input directions in radians
inputDirs = 0:0.01:pi;

%{
For the following script, here is the architecture:
Neuron1 (tuned to 45 degrees)
Neuron2 (tuned to 90 degrees)
Neuron3 (tuned to 135 degrees)
Neuron4 (tuned to 180 degrees)

Each neuron sends to a horizontal and vertical neuron
    with varying weights. 

The horizontal and vertical neuron sends 
    an inhibitory signal to each other
%}

%{
The following is the original architecutre with and without inhibtion
    and where the weights are all uniform, meaning the following:
	- Neuron1 and Neuron2 have a uniform weight to the vertical neuron
        and a zero weight to the horizontal neuron
    - Neuron3 and Neuron4 have a uniform weight to the horizontal neuron 
        and a zero weight to the vertical weight
    - The inhibitory weight is either 0 or -0.3

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
    'Location','southoutside');

%{
With this network, we want more emphasis on the 90 degree neuron than on
    the 45 degree neuron when testing if vertical. Similarly, we want more
    emphasis on the 180 degree neuron than on the 135 degree neuron. For
    this reason, I tested skewed weights here to see the horizontal and
    vertical neuron output. 
The architecture is the same as the previous one with two differences:
    - Neuron1 has a smaller weight than Neuron2
    - Neuron3 has a smaller weight than Neuron4

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
    'Vertical Neuron Firing Rate with 70% weight on 45 degree neuron',...
    'Horizontal Neuron Firing Rate with 70% weight on 135 degree neuron',...
    'Vertical Neuron Firing Rate with 40% weight on 45 degree neuron',...
    'Horizontal Neuron Firing Rate with 40% weight on 135 degree neuron',...
    'Location','southoutside');

%{
After finding out that the weights should be skewed, I am next going to go
    with the new architecture for this problem. 
For the horizontal neuron,
    I will want to accept input from the 45 degree neuron, 135 degree
    neuron, and 180 degree neuron with most of the weight being with the
    180 degree neuron. 
Along those same lines, the vertical output gets the
    most information from the 90 degree neuron and some from the 135 and 45
    degree neuron. 
The horizontal output gets 0 weight from the 90 degree
    neuron and the vertical output gets 0 weight from the 180 degree
    neuron.

Results:
This seems to dampen the differences slightly, but the peaks do 
    seem closer to where I want them to be, so I will keep this 
    weight paradigm
%}

neuronPrefDirs = [pi/4 pi/2 3*pi/4 pi];
HtoVweight = -0.3;
VtoHweight = -0.3;

%old architecture weights
neuronHorizWeights = [0 0 40 100];
neuronVertWeights = [40 100 0 0];

[outputHoriz,outputVert] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,0);

%new architecture weights
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
title('Firing Rate Output with old and new architecture');
hold off
legend('Vertical Neuron Firing Rate with old architecture',...
    'Horizontal Neuron Firing Rate with old architecture',...
    'Vertical Neuron Firing Rate with new architecture',...
    'Horizontal Neuron Firing Rate with new architecture',...
    'Location','southoutside');


%{
I am still having the issue that around 0 degrees, neither the horizontal
    or vertical neuron output much. This is occuring because none of the
    degree oriented neurons are near 0 degrees. The 180 degree neuron will
    have no firing near zero due to a negative cosine. 
For this problem though we care about the magnitude of the cosine rather
    than whether it is positive or negative, so I decided to change the
    tuning curve function to absolute value of the cosine to see the
    result. 
The graph shows the firing rate with the old and new functions.

Results:
With the new function, you get exactly the type of firing that you would
    want. The horizontal firing rate has its max at 0 and 180 degrees and
    its min at 90 degrees. The vertical firing rate has its max at 90
    degrees and its min at 0 and 180 degrees. 
%}

neuronPrefDirs = [pi/4 pi/2 3*pi/4 pi];
HtoVweight = -0.3;
VtoHweight = -0.3;

neuronHorizWeights = [40 0 40 100];
neuronVertWeights = [40 100 40 0];

%uses the old function
[outputHoriz,outputVert] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,0);

%uses the new function
[outputHoriz1,outputVert1] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,1);
   

figure
hold on
plot(radtodeg(inputDirs),outputVert,'r--');
plot(radtodeg(inputDirs),outputHoriz,'g--');
plot(radtodeg(inputDirs),outputVert1,'r-');
plot(radtodeg(inputDirs),outputHoriz1,'g-');
xlabel('Angle in Degrees');
ylabel('Firing Rate');
title('Firing Rate Output with old and new function');
hold off
legend('Vertical Neuron Firing Rate with old function',...
    'Horizontal Neuron Firing Rate with old function',...
    'Vertical Neuron Firing Rate with new function',...
    'Horizontal Neuron Firing Rate with new function',...
    'Location','southoutside');

%{
Given the previous success, I decided to see if adding a neuron tuned to 0
    degrees helps. It has the same weight as the 180 degree neuron for the 
    horizontal and vertical output. I kept the old tuning curve function
    for this test.

Results:
The horizontal and vertical output look very similar to the case where I
    changed the tuning function to absolute value of the cosine. Thus it
    seems that adding a neuron tuned to 0 degrees also helps make the
    output look as expected. 
%}

neuronPrefDirs = [pi/4 pi/2 3*pi/4 pi];
HtoVweight = -0.3;
VtoHweight = -0.3;

neuronHorizWeights = [40 0 40 100];
neuronVertWeights = [40 100 40 0];

%uses the current architecture
[outputHoriz,outputVert] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,0);

neuronPrefDirs = [0 pi/4 pi/2 3*pi/4 pi];
neuronHorizWeights = [100 40 0 40 100];
neuronVertWeights = [0 40 100 40 0];
   
%uses the experimental architecture
[outputHoriz1,outputVert1] = getOutArray(inputDirs,neuronPrefDirs,...
       neuronHorizWeights,neuronVertWeights,HtoVweight,VtoHweight,0);
   

figure
hold on
plot(radtodeg(inputDirs),outputVert,'r--');
plot(radtodeg(inputDirs),outputHoriz,'g--');
plot(radtodeg(inputDirs),outputVert1,'r-');
plot(radtodeg(inputDirs),outputHoriz1,'g-');
xlabel('Angle in Degrees');
ylabel('Firing Rate');
title('Firing Rate Output with current and experimental architecture');
hold off
legend('Vertical Neuron Firing Rate with current architecture',...
    'Horizontal Neuron Firing Rate with current architecture',...
    'Vertical Neuron Firing Rate with experimental architecture',...
    'Horizontal Neuron Firing Rate with experimental architecture',...
    'Location','southoutside');

%{
Conclusion:
The given architecture works well in detecting how horizontal or vertical
    the input direction is for angles between 45 and 180 degrees. However
    in the 0 to 45 degree range, there is a deficiency. It is mostly
    horizontal there but the horizontal output cannot be as high as desired
    unless some modification is made to the architecture. 
I tested two modifications that worked well:
    1. Changing the tuning function to absolute value. The main benefit
        this provided was that the 180 degree neuron had a firing rate near
        0 degrees
    2. Adding a neuron at 0 degrees but keeping the tuning function the same.
        This had a similar benefit to 1
%}


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
    
function [ y ] = radtodeg( x )
%RADTODEG Converts radians to degrees

y = x*180/pi;
end

function [ horizNeuronOutput,vertNeuronOutput ] = getNeuralNetOut( ...
    inputDir, neuronPrefDirs,neuronHorizWeights, neuronVertWeights,...
    horizToVertInhib, vertToHorizInhib, spflag  )
%GETNEURALNETOUTPUT Gets the horizontal and vertical neuron output
%       given the network parameters and input

%{
Assumes the network is structured as follows:
    neurons whose preferred directions are in neuronPrefDirs
    Each of those neurons sends to a horizontal and vertical output
        neuron via a weight specified in the parameters
    The horizontal and vertical neurons send inhibitory signals to each
        other
%}


%this calculates the initial feed-forward excitation of the input neurons
%   we now have the contribution of those input neurons to the horizontal
%       and vertical neurons
horizNeuronExcit = zeros(1,4);
vertNeuronExcit = zeros(1,4);
for i = 1:length(neuronPrefDirs);
   horizNeuronExcit(i) = getFeedForwardOutput(inputDir,...
       neuronPrefDirs(i),neuronHorizWeights(i),spflag); 
   vertNeuronExcit(i) = getFeedForwardOutput(inputDir,...
       neuronPrefDirs(i),neuronVertWeights(i),spflag); 
end
vertNeuronExcitation = sum(vertNeuronExcit);
horizNeuronExcitation = sum(horizNeuronExcit);

%this calculates the final vertical and horizontal output
%   it is the excitation minus the inhibition from the other neuron
vertNeuronOutput = vertNeuronExcitation + ...
    horizToVertInhib*horizNeuronExcitation;
horizNeuronOutput = horizNeuronExcitation + ...
    vertToHorizInhib*vertNeuronExcitation;


end

function [ output ] = getFeedForwardOutput( inputAngle,preferredAngle,weight , spflag)
%GETFEEDFORWARDOUTPUT Calculates the feed-forward excitation which
%       is the cosine of the inputAngle with the preferredAngle
%       multiplied by a weight value
%
%If the special flag is enabled, then the feed-forward exictation is the 
%       absolute value of the cosine of the inputAngle with the
%       preferredAngle multipled by the weight value

output = max(0,cos(inputAngle-preferredAngle))*weight;
if(spflag==1)
    output = abs(cos(inputAngle-preferredAngle))*weight;
end

end


    

end

