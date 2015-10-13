function [ ] = goldman2( )
%GOLDMAN2 Plots b value versus Em

bVals = 0:0.02:20;
emVals = zeros(size(bVals));
for i = 1:length(bVals)
    emVals(i) = getEm(bVals(i));
end

figure
plot(bVals,emVals);
title('b value versus Em');
xlabel('Ratio of Sodium to Potassium Permeability (b value)');
ylabel('Membrane Potential (mV)');

end

