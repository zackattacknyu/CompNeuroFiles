%this is the reproduction of 1.7B from the book


%tuning curve x values
ss = -1:0.01:1;

%tuning curve parameter values
s_half = 0.036;
deltaS = 0.029;
r_max = 36.03;

%function to generate tuning curve
ff = @(xx,gain) r_max./(1+exp((s_half-xx)./(deltaS*gain)));

%varying widths
gain1=1;
gain2= 2;
gain3 = 0.5;

figure
hold on
plot(ss,ff(ss,gain1),'r-');
plot(ss,ff(ss,gain2),'b-');
plot(ss,ff(ss,gain3),'g-');
legend('Original Curve',...
    'Width=2 revolution',...
    'Width = 1/2 revolution');
legend('Original Curve');
hold off
title('Logistic Tuning Curve with varying gain values');
xlabel('s (retinal disparity in degrees)');
ylabel('f (Hz)');
