function [ ] = FINAL_make3figure( rewards,z,ratPathsX,ratPathsY )
%FINAL_MAKE3FIGURE Make the 3-panel figure 1 and 3
%  
%INPUT
%   rewards - reward centers
%   z - actor values
%   ratPathsX - paths rat took, x coordinates
%   ratPathsY - paths rat took, y coordinates

numRewards = size(rewards,1);

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

%makes dot and reward center figure
figure
subplot(311)
scatter(pc.x,pc.y,10,'b.')
hold on
for rNum = 1:numRewards
    reward = rewards(rNum,:);
    scatter(reward(1),reward(2),100,'go')
end 
axis square;
hold off

%makes figure of actor gradients
subplot(312)
vectorPlot(z,pc);
axis square;

%color order
%ensures differently colored lines if using older version of Matlab
co = [0    0.4470    0.7410;
    0.8500    0.3250    0.0980;
    0.9290    0.6940    0.1250;
    0.4940    0.1840    0.5560;
    0.4660    0.6740    0.1880;
    0.3010    0.7450    0.9330;
    0.6350    0.0780    0.1840];

%plots the paths the rat took superimposed with reward centers
subplot(313)
hold on
for i = 1:length(ratPathsX)
    colorRow = mod(i,size(co,1))+1;
   plot(ratPathsX{i},ratPathsY{i},'--','Color',co(colorRow,:)); 
end
plot(rewards(:,1),rewards(:,2),'rx','LineWidth',3);
hold off;

end

