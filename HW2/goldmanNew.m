kPlusOut = 5;
kPlusIn = 125;
NaPlusOut = 120;
NaPlusIn = 12;
ClMinusIn = 5;
ClMinusOut = 125;
c=1;

b = 0.02;

numer = kPlusOut + b*NaPlusOut + c*ClMinusIn;
denom = kPlusIn + b*NaPlusIn + c*ClMinusOut;
em = 58*log10(numer/denom);

Ecl = 58*log10(ClMinusIn/ClMinusOut);
EK = 58*log10(kPlusOut/kPlusIn);
ENa = 58*log10(NaPlusOut/NaPlusIn);

gK = 0.1;
gN = 0.1;
gCl = 0.1;
iK = gK*(em-EK);
iNa = gN*(em-ENa);
iCl = gCl*(em-Ecl);



