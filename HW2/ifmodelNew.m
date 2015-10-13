
Rm = 10;
EL = -60;
Vth = -50;
tauM = 10;

V0 = -60;
Ie=1.05;

voltVals = zeros(1,1000);
lastFireT = 0;
curV = -60;
for t=0:1000
    curV = curV + (EL - curV + Rm*Ie)/tauM;
    voltVals(t+1) = curV;
    if(curV > Vth)
       curV = -60;
    end
end
plot(voltVals)
