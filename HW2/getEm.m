function em = getEm(b)
%GETEM Calculates the goldman equation for different b values

    kPlusOut = 5;
    kPlusIn = 125;
    NaPlusOut = 120;
    NaPlusIn = 12;
    ClMinusIn = 5;
    ClMinusOut = 125;
    c=1;

    numer = kPlusOut + b*NaPlusOut + c*ClMinusIn;
    denom = kPlusIn + b*NaPlusIn + c*ClMinusOut;
    em = 58*log10(numer/denom);
    
end

