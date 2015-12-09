global radius;
global obstacle;

%default parameter values from morris_water_maze.m
dirs = 8; % possible headings
beta = 2; % for softmax
radius = 1.0; % arena is 2 meters wide
sigma = 0.16; % place cell tuning width of 0.16m
reward_value = 1;
eta = 0.01; % learning rate

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

rewards = [citiesLong citiesLat];
%reward_vals = citiesRew;
reward_vals = ones(size(rewards,1),1); %values for each reward, which decrease. 

%for European cities
rewardDecFactor = 0.95; %factor to decrease reward value by each time
rewardDecValue = 0;

%rewardDecValue = 0.075; %value to decrease reward value
epsilonThresh = 0.3;

numRewards = size(rewards,1);

obstacle = [1.0 1.0];

z = zeros(dirs,inx); % actor weights
w = zeros(1,inx); % critic weights

%TRIALS =20;
TRIALS =50; %for European cities

for trial = 1:TRIALS
    
    % get rat's initial position. start each trial in a different quadrant
    rat = getInitLocation(trial);
    
    % let the rat explore for 100 time steps or until it gets reward
    t = 1;
    found_reward = 0;
    v = 0;
    a = zeros(1,8);
    prevAct=1;
    
    % run for 250 moves or until a reward is found. whichever comes first
    while t <= 250 && ~found_reward;
        
        % choose an action and move rat to new location
        act = action_select (a, beta);
        act = adjustAct(act,prevAct);
        prevAct = act;
        rat = move2(act, rat);
        
        % save off the old critic value. calculate the new critic value
        % based on the rat's current position. calculate the actor value
        % for each direction.
        vpre = v;
        v = 0;
        a = zeros(1,8);
        for i=1:inx
            
            % get place cell activity
            pc.act(i) = place_cell([rat.x rat.y], [pc.x(i) pc.y(i)]);
            
            % calculate current value for critic based on weight and place
            % cell activity
            v = v + w(i)*pc.act(i);
            
            % calculate actor values based on weights and place cell
            % activity
            for j = 1:dirs
                a(j) = a(j) + z(j,i)*pc.act(i);
            end
        end
        
        % if rat is within 0.2 meters of platform, give reward
        for rNum = 1:numRewards
            reward = rewards(rNum,:);
            found_reward1 = norm([rat.x rat.y]-reward) < 0.2;
            found_reward = found_reward1 && reward_vals(rNum)>epsilonThresh;
            if(found_reward)
                reward_value = reward_vals(rNum);
                reward_vals(rNum) = reward_vals(rNum)*rewardDecFactor;
                reward_vals(rNum) = reward_vals(rNum)-rewardDecValue;
                break
            end
            
        end
        
        % get TD delta rule
        d = delta2(v, vpre, reward_value * found_reward);
        
        % update the critic's weights
        w = w + eta*d*pc.act;
        
        % update the actor's weights
        z(act,:) = z(act,:) + eta*d*pc.act;
        
        t = t + 1;
        
        

    end
    
    %if there are no more rewards for the rat
    if(isempty(find(reward_vals>epsilonThresh, 1)))
        break;
    end

    
    if(mod(trial,1)==0)
        subplot(121)
        scatter(pc.x,pc.y,10,'b.')
        hold on
        scatter(rat.x, rat.y,50,'ro')
        for rNum = 1:numRewards
            reward = rewards(rNum,:);
            scatter(reward(1),reward(2),100,'go')
        end 
        axis square;
        hold off
        subplot(122)
        vectorPlot(z,pc);
        axis square;
        drawnow;
    end

end
%%

subplot(121)
scatter(pc.x,pc.y,10,'b.')
hold on
%scatter(rat.x, rat.y,50,'ro')
for rNum = 1:numRewards
    reward = rewards(rNum,:);
    scatter(reward(1),reward(2),100,'go')
end 
axis square;
hold off
subplot(122)
vectorPlot(z,pc);
axis square;
drawnow;
%%


%runs trials without updating weights
%records the paths that the rat takes

TRIALS2 = 15;
locInd=1;
placeCellHits = zeros(size(pc.x));
ratLocsX = zeros(1,250);
ratLocsY = zeros(1,250);
ratPathsX = cell(1,TRIALS2);
ratPathsY = cell(1,TRIALS2);
for trial = 1:TRIALS2
    
    % get rat's initial position. start each trial in a different quadrant
    %rat = getInitLocation(trial);
    rat = getRandLocation(0.1,0.9);
    
    % let the rat explore for 100 time steps or until it gets reward
    t = 1;
    found_reward = 0;
    v = 0;
    a = zeros(1,8);
    prevAct=1;
    
    % run for 100 moves or until a reward is found. whichever comes first
    locInd=1;
    while t <= 100;
        
        % choose an action and move rat to new location
        act = action_select (a, beta);
        %act = adjustAct(act,prevAct);
        %prevAct = act;
        rat = move2(act, rat);
        
        ratLocsX(locInd)=rat.x;
        ratLocsY(locInd)=rat.y;
        locInd = locInd+1;
        
        % save off the old critic value. calculate the new critic value
        % based on the rat's current position. calculate the actor value
        % for each direction.
        a = zeros(1,8);
        for i=1:inx
            
            % get place cell activity
            pc.act(i) = place_cell([rat.x rat.y], [pc.x(i) pc.y(i)]);
            
            % calculate actor values based on weights and place cell
            % activity
            for j = 1:dirs
                a(j) = a(j) + z(j,i)*pc.act(i);
            end
        end

        % if rat is within 0.2 meters of platform, give reward
        for rNum = 1:numRewards
            reward = rewards(rNum,:);
            found_reward = norm([rat.x rat.y]-reward) < 0.2;
            if(found_reward)
               break; 
            end
        end
        
        t = t + 1;
        
        
        

    end
    
    ratLocsX = ratLocsX(1:(locInd-1));
    ratLocsY = ratLocsY(1:(locInd-1));
    ratPathsX{trial} = ratLocsX;
    ratPathsY{trial} = ratLocsY;
    
    trial
    
    latency(trial) = t;
end
%%
figure
subplot(311)
scatter(pc.x,pc.y,10,'b.')
hold on
%scatter(rat.x, rat.y,50,'ro')
for rNum = 1:numRewards
    reward = rewards(rNum,:);
    scatter(reward(1),reward(2),100,'go')
end 
axis square;
hold off

subplot(312)
vectorPlot(z,pc);
axis square;

co = [0    0.4470    0.7410;
    0.8500    0.3250    0.0980;
    0.9290    0.6940    0.1250;
    0.4940    0.1840    0.5560;
    0.4660    0.6740    0.1880;
    0.3010    0.7450    0.9330;
    0.6350    0.0780    0.1840];
subplot(313)
hold on
for i = 1:TRIALS2
    colorRow = mod(i,size(co,1))+1;
   plot(ratPathsX{i},ratPathsY{i},'--','Color',co(colorRow,:)); 
end
plot(rewards(:,1),rewards(:,2),'rx','LineWidth',3);
hold off;

%%

%%
figure

subplot(211)
vectorPlot(z,pc);
axis square;

co = [0    0.4470    0.7410;
    0.8500    0.3250    0.0980;
    0.9290    0.6940    0.1250;
    0.4940    0.1840    0.5560;
    0.4660    0.6740    0.1880;
    0.3010    0.7450    0.9330;
    0.6350    0.0780    0.1840];
subplot(212)
hold on
for i = 1:TRIALS2
    colorRow = mod(i,size(co,1))+1;
   plot(ratPathsX{i},ratPathsY{i},'--','Color',co(colorRow,:)); 
end
plot(rewards(:,1),rewards(:,2),'rx','LineWidth',3);
hold off;

%%

placeCellInfo = w;
sortedX = unique(pc.x);
sortedY = unique(pc.y);
placeCellMatrix = zeros(length(sortedY),length(sortedX));
for i = 1:length(placeCellInfo)
    xCur = pc.x(i);
    yCur = pc.y(i);
    
    curCol = find(xCur==sortedX,1);
    curRow = find(yCur==sortedY,1);
    
    curVal = placeCellInfo(i);
    placeCellMatrix(curRow,curCol)=curVal;

end
placeCellMatrix = flipud(placeCellMatrix);
figure
imagesc(placeCellMatrix);
hold on
plot(rewards(:,1),rewards(:,2),'rx','LineWidth',3);
hold off
colorbar;
