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

