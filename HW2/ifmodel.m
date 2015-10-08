%values for 5.5
Rm = 10;
EL = -65;
Vth = -50;
tauM = 10;

Ie = 1;

V0 = -65;

V = @(t) EL + Rm*Ie + (V0 - EL - Rm*Ie)*exp(-t/tauM);

tVals = 0:1:500;
Vvals = V(tVals);

plot(tVals,Vvals);