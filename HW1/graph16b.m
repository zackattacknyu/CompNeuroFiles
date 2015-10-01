%this is the reproduction of 1.6B from the book


%tuning curve x values
ss = 0:1:360;

%tuning curve parameter values
r0 = 32.34;
s_max = 161.25;
r_max = 54.69;

%function to generate tuning curve
ff = @(xx,width) r0 + (r_max - r0)*cosd((xx-s_max)/width);

%varying widths
width1 = 1;
width2 = 2;
width3 = 0.5;

figure
hold on
plot(ss,ff(ss,width1),'r-');
plot(ss,ff(ss,width2),'b-');
plot(ss,ff(ss,width3),'g-');
legend('Original Curve',...
    'Width=2 revolution',...
    'Width = 1/2 revolution');
hold off
xlabel('s (movement direction in degrees)');
ylabel('f (Hz)');
