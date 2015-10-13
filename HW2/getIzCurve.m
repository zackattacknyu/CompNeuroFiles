function [ freqVals ] = getIzCurve( iVals,aa,bb,cc,dd )
%GETIZCURVE Summary of this function goes here
%   Detailed explanation goes here

V0 = cc;
Vth = 30;
numTimeSteps=2000;
curU = bb*V0; %initial value for u, from paper

freqVals = zeros(size(iVals));
for j = 1:length(iVals)
    curI = iVals(j);
    curV = V0;
    for t=0:numTimeSteps
        curV = curV + (0.04*curV^2 + 5*curV + 140 - curU + curI);
        curU = curU + aa*(bb*curV-curU);
        if(curV > Vth)
           curV = cc;
           curU = curU + dd;
           freqVals(j) = freqVals(j) + 1;
        end
    end
end

end

