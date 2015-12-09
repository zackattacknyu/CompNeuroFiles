function [  ] = FINAL_makeWfigure( w )
%FINAL_MAKEWFIGURE Summary of this function goes here
%   Detailed explanation goes here
radius = 1.0; % arena is 2 meters wide
sigma = 0.16; % place cell tuning width of 0.16m

% set up place cell indices across circular arena
inx = 0;
for i = -radius:sigma/2:radius
    for j = -radius:sigma/2:radius
        if norm([i j]) < radius
            inx = inx + 1;
            pc.x(inx) = i;
            pc.y(inx) = j;
        end
    end
end

sortedX = unique(pc.x);
sortedY = unique(pc.y);
wMatrix = zeros(length(sortedY),length(sortedX));
for i = 1:length(w)
    xCur = pc.x(i);
    yCur = pc.y(i);
    
    curCol = find(xCur==sortedX,1);
    curRow = find(yCur==sortedY,1);
    
    curVal = w(i);
    wMatrix(curRow,curCol)=curVal;

end
wMatrix = flipud(wMatrix);
figure
imagesc(wMatrix);
colorbar;

end

