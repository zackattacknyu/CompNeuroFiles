function [ freqVals ] = getIzCurve( iVals,aa,bb,cc,dd )
%GETIZCURVE Takes in current values and parameters and finds the frequency
%vs current curve
%
%INPUT
%   iVals - array of current values in nA
%   aa, bb, cc, dd - a,b,c,d in Izhikevich model
%
%
%OUTPUT
%   freqVals - array of frequency values in Hz

%threshold voltage, from slide on Izhikevich model slide
Vth = 30; 

%after doing some testing, it took about 500 steps
%   when current was 0 for u and v to reach a steady state
numStepsToSteady=500;

%number of active time steps in one second since 
%   each time step is 1/2 ms
numTimeSteps=2000;

%find initial u and v values by iterating until steady state
%   no current is being injected here
curV = cc; curU = bb*cc; %initial guesses for u and v, from code
for t=0:numStepsToSteady
    curV = curV + (0.04*curV^2 + 5*curV + 140 - curU);
    curU = curU + aa*(bb*curV-curU);
    if(curV > Vth)
       curV = cc;
       curU = curU + dd;
    end
end
initU = curU;
initV = curV;

%Now that we have initial u and v values, find the number
%   of times the neurons fires in the span of 2000 time steps
%   in order to get the frequency in Hz for each value of current
freqVals = zeros(size(iVals));
for j = 1:length(iVals)
    curI = iVals(j);
    curV = initV;
    curU = initU;
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

