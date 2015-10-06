%this is the reproduction of 1.6B from the book

%{
The figures generated from running this script show the effect of chaning
the parameters of the tuning curve

Figure 1 shows the effect of changing the tuning width
    - the spread of the curve increases or decreases

Figure 2 shows the effect of changing the min firing rate
    - the bottom of the curve changes

Figure 3 shows the effect of changing the max firing rate
    - the top of the curve changes

Figure 4 shows the effect of changing the preferred direction
    - the curve shifts left or right

%}


%tuning curve x values
ss = 0:1:360;

%tuning curve parameter values
r0 = 32.34;
s_max = 161.25;
r_max = 54.69;

%function to generate tuning curve
ff = @(xx,width,r0,s_max,r_max) r0 + (r_max - r0)*cosd((xx-s_max)/width);

%varying widths
width1 = 1;
width2 = 2;
width3 = 0.5;

f1 = @(widthParam) ff(ss,widthParam,r0,s_max,r_max);

figure
hold on
plot(ss,f1(width1),'r-');
plot(ss,f1(width2),'b-');
plot(ss,f1(width3),'g-');
legend('Original Curve',...
    'Width = 2 revolutions',...
    'Width = 1/2 revolution','Location','eastoutside');
hold off
title('Cosine Tuning Curve with varying widths');
xlabel('s (movement direction in degrees)');
ylabel('f (Hz)');

width=1;

%varying min rates
r0_1 = 32.34;
r0_2 = 40;
r0_3 = 16;

f2 = @(r0Param) ff(ss,width,r0Param,s_max,r_max);

figure
hold on
plot(ss,f2(r0_1),'r-');
plot(ss,f2(r0_2),'b-');
plot(ss,f2(r0_3),'g-');
legend('Original Curve',...
    'MinRate = 40 Hz',...
    'MinRate = 16 Hz','Location','eastoutside');
hold off
title('Cosine Tuning Curve with varying min firing rates');
xlabel('s (movement direction in degrees)');
ylabel('f (Hz)');

r0=32.34;

%varying max rates
rmax1 = 54.69;
rmax2 = 40;
rmax3 = 70;

f3 = @(rmaxParam) ff(ss,width,r0,s_max,rmaxParam);

figure
hold on
plot(ss,f3(rmax1),'r-');
plot(ss,f3(rmax2),'b-');
plot(ss,f3(rmax3),'g-');
legend('Original Curve',...
    'MaxRate = 40 Hz',...
    'MaxRate = 70 Hz','Location','eastoutside');
hold off
title('Cosine Tuning Curve with varying max firing rates');
xlabel('s (movement direction in degrees)');
ylabel('f (Hz)');


r_max = 54.69;

%varying preferred directions
smax1 = 161.25;
smax2 = 100;
smax3 = 250;

f4 = @(smaxParam) ff(ss,width,r0,smaxParam,r_max);

figure
hold on
plot(ss,f4(smax1),'r-');
plot(ss,f4(smax2),'b-');
plot(ss,f4(smax3),'g-');
legend('Original Curve',...
    'Preferred Direction = 100 degrees',...
    'Preferred Direction = 250 degrees','Location','eastoutside');
hold off
title('Cosine Tuning Curve with varying preferred directions');
xlabel('s (movement direction in degrees)');
ylabel('f (Hz)');


