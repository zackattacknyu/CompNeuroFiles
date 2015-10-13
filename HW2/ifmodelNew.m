V0 = -65;
Rm = 10;
EL = V0;
Vth = -50;
tauM = 10;

iVals = 0:0.05:4;
freqVals = zeros(size(iVals));

voltVals = zeros(1,1000);
lastFireT = 0;
for j = 1:length(iVals)
    curI = iVals(j);
    curV = V0;
    for t=0:1000
        curV = curV + (EL - curV + Rm*curI)/tauM;
        voltVals(t+1) = curV;
        if(curV > Vth)
           curV = V0;
           freqVals(j) = freqVals(j) + 1;
        end
    end
end

plot(iVals,freqVals);
