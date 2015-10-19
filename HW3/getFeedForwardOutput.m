function [ output ] = getFeedForwardOutput( inputAngle,preferredAngle,weight , spflag)
%GETFEEDFORWARDOUTPUT Summary of this function goes here
%   Detailed explanation goes here

output = max(0,cos(inputAngle-preferredAngle))*weight;
if(spflag==1)
    output = abs(cos(inputAngle-preferredAngle))*weight;
end

end

