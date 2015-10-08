function goldman

    function em = getEm(b)
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

emVals = zeros(1,100);
for i = 1:100
   emVals(i) = getEm(0.02); 
end

for i = 45:55
   emVals(i) = getEm(20); 
end

figure
plot(1:100,emVals);
title('Membrane Potential during different time steps');
xlabel('Time Step');
ylabel('Membrane Potential (mV)');

end