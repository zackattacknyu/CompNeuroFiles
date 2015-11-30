function vectorPlot (wgts, pc)

dirs = size(wgts,1);
inx = 1;
dx = zeros(sqrt(size(wgts,2)));
dy = zeros(sqrt(size(wgts,2)));

for i = 1:sqrt(size(wgts,2))
    for j = 1:sqrt(size(wgts,2))
        for k = 1:dirs
            dx(i,j) = dx(i,j) + wgts(k,inx) * cos(2*pi*(k/dirs));
            dy(i,j) = dy(i,j) + wgts(k,inx) * sin(2*pi*(k/dirs));
            x(i,j) = pc.x(inx);
            y(i,j) = pc.y(inx);
        end
        inx = inx + 1;
    end
end

% [x,y] = meshgrid(1:size(dx,2));
% y = y .*2 ./22 -1;
% x = x .*2 ./22 -1;
quiver(x,y,dx,dy)
axis([-1 1 -1 1])
end