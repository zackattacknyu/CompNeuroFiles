function [  ] = FINAL_makeWfigure( w )
%FINAL_MAKEWFIGURE Makes the critic plot of figure 2, 4, 6, and 8
%
%INPUT 
% w - critic weight


% set up place cell indices across circular arena
radius = 1.0; % arena is 2 meters wide
sigma = 0.16; % place cell tuning width of 0.16m
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

%{
This makes a matrix across the whole maze and zeros 
    each entry by default. 

The number of rows and columns are the greatest number
    of place cells in a single row, thus each place cell
    has its own entry with many extra entries remaining

If an entry corresponds
to a place cell, its critic values is put in that 
part of the matrix.

The matrix values are what is displayed in the end
%}
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

%makes sure matrix will be displayed as expected
wMatrix = flipud(wMatrix);

%displays the matrix values
figure
imagesc(wMatrix);
colorbar;

end

