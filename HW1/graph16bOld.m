%this is the reproduction of 1.6B from the book

%{
In order to get the raw data values, 
I saved a png of the screenshot of the 1.6B
graph and used the pixel values of the points
%}
img1 = imread('graph16bOriginal.png');
image(img1)
[rawS,rawF] = ginput; %gets the raw pixel values
%%
%{
The points were selected in the following order:
1: (0,0)
2: (350,0)
3: (0,60)

These first three points are used for the calibration
Points 4-12 are the data points
%}
zeroS = rawS(1);
zeroF = rawF(1);
scaleS = (rawS(2)-rawS(1))/350;
scaleF = (rawF(3)-rawF(1))/60;

rawDataS = rawS(4:12);
rawDataF = rawF(4:12);
dataS = round((rawDataS-zeroS)/scaleS);
dataF = round((rawDataF-zeroF)/scaleF);

%%
%movement direction in degrees (from above procedure)
sVals = [0 45 90 135 180 225 271 315 360];

%firing rate (from above procedure)
fVals = [14 14 46 52 52 43 25 12 12];

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