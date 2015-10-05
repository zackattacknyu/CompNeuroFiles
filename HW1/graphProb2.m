
xx = -180:1:180;

curve1 = cosd(xx);
curve2 = cosd(xx-90);
curve3 = cosd(xx-180);
curve4 = cosd(xx-270);

curve1(curve1<0)=0;
curve2(curve2<0)=0;
curve3(curve3<0)=0;
curve4(curve4<0)=0;

figure
hold on
plot(xx,curve1,'r:');
plot(xx,curve2,'g-');
plot(xx,curve3,'b--');
plot(xx,curve4,'k:');
hold off
%%
c1 = 1;
c2 = 1i;
c3 = -1;
c4 = -1i;

dirVecs = c1*curve1 + c2*curve2 + c3*curve3 + c4*curve4;
%%

dirs = radtodeg(angle(dirVecs));
%%
error = abs(dirs-xx);
plot(xx,error);
%%plot(dirs);

%%
