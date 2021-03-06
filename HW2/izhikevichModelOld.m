V0 = -55;
Rm = 10;
EL = V0;
Vth = 30;
tauM = 10;
iVals = 0:0.05:300;
numTimeSteps=1000;
freqVals = zeros(size(iVals));

aa = 0.02;
bb = -0.1;
cc = -55;
dd = 6;
curU = bb*V0; %initial value for u, from paper


curI=0;
curV = V0;
vVals = zeros(1,numTimeSteps+1);
uVals = zeros(1,numTimeSteps+1);
for t=0:numTimeSteps
    curV = curV + (0.04*curV^2 + 5*curV + 140 - curU + curI);
    curU = curU + aa*(bb*curV-curU);
    if(curV > Vth)
       curV = cc;
       curU = curU + dd;
    end
    vVals(t+1)=curV;
    uVals(t+1)=curU;
end

figure
plot(vVals);
xlabel('Time Step');
ylabel('V Value');

figure
plot(uVals);
xlabel('Time Step');
ylabel('U Value');