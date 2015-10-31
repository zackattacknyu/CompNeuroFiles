% Sigmoid Activation
%   Input:  I - synaptic input
%           g - gain
%   Output: firing rate of sigmoid function
function r = sigmoidN (I, g) 
r = 1/(1+exp(-g*I));
end