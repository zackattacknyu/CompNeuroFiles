%this is the reproduction of 1.7B from the book


%tuning curve x values
ss = -1:0.01:1;

%tuning curve parameter values
s_half = 0.036;
deltaS = 0.029;
r_max = 36.03;

%function to generate tuning curve
ff = @(xx) r_max./(1+exp((s_half-xx)./deltaS));

%varying widths
width1 = 1;
width2 = 2;
width3 = 0.5;

figure
hold on
plot(ss,ff(ss),'r-');
legend('Original Curve');
hold off
xlabel('s (movement direction in degrees)');
ylabel('f (Hz)');
