%this is the reproduction of 1.6B from the book

%movement direction in degrees (estimates based on graph)
sVals = [0 50 100 140 180 230 270 320 360];

%firing rate (estimates for numbers based on graph)
fVals = [13 13 44 51 51 40 20 10 10];

%tuning curve x values
tunCurveX = 0:1:360;

%tuning curve y values and parameter values
r0 = 32.34;
s_max = 161.25;
r_max = 54.69;
tunCurveY = r0 + (r_max - r0)*cosd(tunCurveX-s_max);

figure
plot(sVals,fVals,'b.');
hold on
plot(tunCurveX,tunCurveY,'r-');
hold off