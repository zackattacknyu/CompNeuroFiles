function goldman

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