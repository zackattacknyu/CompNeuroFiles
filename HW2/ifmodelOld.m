
iVals = 0:0.01:4;

Rm = 10;
EL = -65;
Vth = -50;
tauM = 10;

V0 = -65;

numer = Rm.*iVals + EL - V0;
denom = Rm.*iVals + EL - Vth;

rInterInv = tauM.*log(numer./denom);

rInter = (rInterInv).^(-1);

figure
plot(iVals,rInter);
title('Firing Rate versus Current');
xlabel('Current (nA)');
ylabel('Firing Rate (Hz)');