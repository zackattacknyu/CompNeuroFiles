
%initial ion concentrations
kPlusOut = 5;
kPlusIn = 125;
NaPlusOut = 120;
NaPlusIn = 12;
ClMinusIn = 5;
ClMinusOut = 125;

%goldman equation parameters
b = 0.02;
c = 1;

numer = kPlusOut + b*NaPlusOut + c*ClMinusIn;
denom = kPlusIn + b*NaPlusIn * c*ClMinusOut;
Em = 58*log10(numer/denom);

Ecl = 58*log10(ClMinusIn/ClMinusOut);
EK = 58*log10(kPlusOut/kPlusIn);
Ena = 58*log10(NaPlusOut/NaPlusIn);

getEm = @(b) 58*log10(numer/denom);
