% Cosine Tuning 
% Used absolute value for orientation tuning
%   / - \ |
%   Input:  pd - preferred direction
%           a - angle in radians
%   Output: firing rate based on cosine tuning curve
function r = cosTune(pd, a)
r = abs(cos(a-pd));
end