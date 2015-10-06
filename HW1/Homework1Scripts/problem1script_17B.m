%this is the reproduction of 1.7B from the book

%{
The figures generated from running this script show the effect of chaning
the parameters of the logistic curve

Figure 1 shows the effect of changing the gain
    - the steepness of the curve is affected
    - goes between near step function and s curve

Figure 2 shows the effect of changing the max firing rate
    - the top of the curve changes

%}



%tuning curve x values
ss = -1:0.01:1;

%tuning curve parameter values
s_half = 0.036;
deltaS = 0.029;
r_max = 36.03;

%function to generate logistic tuning curve
ff = @(xx,gain) r_max./(1+exp((s_half-xx)./(deltaS*gain)));

%varying multipliers to original gain
gain1=1;
gain2= 5;
gain3 = 0.2;

%generate figure 1, which is described at the top
figure
hold on
plot(ss,ff(ss,gain1),'r-');
plot(ss,ff(ss,gain2),'b-');
plot(ss,ff(ss,gain3),'g-');
legend('Original Curve',...
    'DeltaS=0.1450',...
    'DeltaS=0.0058','Location','eastoutside');
hold off
title('Logistic Tuning Curve with varying gain values');
xlabel('s (retinal disparity in degrees)');
ylabel('f (Hz)');

%function to generate logistic tuning curve
ff2 = @(xx,rmaxParam) rmaxParam./(1+exp((s_half-xx)./deltaS));

%varying max firing rates
rmax1=36.03;
rmax2=18;
rmax3=54;

%generate figure 2, which is described at the top
figure
hold on
plot(ss,ff2(ss,rmax1),'r-');
plot(ss,ff2(ss,rmax2),'b-');
plot(ss,ff2(ss,rmax3),'g-');
legend('Original Curve',...
    'max firing rate = 18 Hz',...
    'max firing rate = 54 Hz','Location','eastoutside');
hold off
title('Logistic Tuning Curve with varying max firing rates');
xlabel('s (retinal disparity in degrees)');
ylabel('f (Hz)');