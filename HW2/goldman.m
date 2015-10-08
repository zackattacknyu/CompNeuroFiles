
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

%numer = kPlusOut + b*NaPlusOut + c*ClMinusIn;
%denom = kPlusIn + b*NaPlusIn * c*ClMinusOut;
%Em = 58*log10(numer/denom);

%Ecl = 58*log10(ClMinusIn/ClMinusOut);
%EK = 58*log10(kPlusOut/kPlusIn);
%Ena = 58*log10(NaPlusOut/NaPlusIn);

getEm = @(b) 58*log10(kPlusOut + b*NaPlusOut + c*ClMinusIn...
    /kPlusIn + b*NaPlusIn * c*ClMinusOut);

emVals = zeros(1,100);
for i = 1:100
   emVals(i) = getEm(0.02); 
end

for i = 45:55
   emVals(i) = getEm(20); 
end

