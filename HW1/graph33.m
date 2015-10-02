%multiple cosine curves

ss = 0:1:360;

ff = @(xx,sMax) cosd(xx-sMax);

figure
hold on
plot(ss,ff(ss,0));
plot(ss,ff(ss,60),'r:');
plot(ss,ff(ss,120),'b--');
hold off