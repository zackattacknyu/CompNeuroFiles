%{
BIG ISSUE: BORDERS
Rat can get stuck on border between regions
    that favor different reward regions
This means the rat appears to be there more often

IDEA:
Maintain different actor-critic arrays per reward center

IDEA 2:
For each trail, start at reward center and leave out starting 
    reward center

%}
global radius;
global obstacle;

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

%reward = [0.50 -0.50];
rewards = [0.5 -0.5; -0.5 0.5; 0.5 0.5; -0.5 -0.5];
%rewards = [0.5 -0.5; -0.5 0.5];

globalRewards = rewards;


%makes random reward centers
%{
rewards = zeros(3,2);
reward_r = rand(3,1)*0.8;
reward_theta = rand(3,1)*2*pi;
reward_complex = reward_r.*exp(reward_theta*1i);
rewards(:,1)=real(reward_complex);
rewards(:,2)=imag(reward_complex);
%}
numRewards = size(rewards,1);

obstacle = [1.0 1.0];

z = zeros(dirs,inx); % actor weights
w = zeros(1,inx); % critic weights
TRIALS = 30;
latency = zeros(1,TRIALS);

for trial = 1:TRIALS
    
    % get rat's initial position. start each trial in a different quadrant
    rat = getInitLocation(trial);
    
    %{
    curRewardNum = mod(trial,numGlobalRewards)+1;
    ratPos = globalRewards(curRewardNum,:);
    activeRewards = setdiff(1:numGlobalRewards,curRewardNum);
    rewards = globalRewards(activeRewards,:);
    rat.x = ratPos(1);rat.y = ratPos(2);
    %}
    
    % let the rat explore for 100 time steps or until it gets reward
    t = 1;
    found_reward = 0;
    v = 0;
    a = zeros(1,8);
    
    % run for 100 moves or until a reward is found. whichever comes first
    while t <= 250;
        
        % choose an action and move rat to new location
        act = action_select (a, beta);
        rat = move (act, rat);
        
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
            found_reward = norm([rat.x rat.y]-reward) < 0.2;
            if(found_reward)
                break
            end
            
        end
        
        %         if found_reward
        %             disp(['Found reward at time ', num2str(t), ' on trial ', num2str(trial)])
        %         end
        
        % get TD delta rule
        d = delta2(v, vpre, reward_value * found_reward);
        
        % update the critic's weights
        w = w + eta*d*pc.act;
        
        % update the actor's weights
        z(act,:) = z(act,:) + eta*d*pc.act;
        
        t = t + 1;
        
        

    end

    
    if(mod(trial,1)==0)
        %subplot(131)
        %scatter3(pc.x,pc.y,pc.act)
        %axis square;
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
    
    latency(trial) = t;
end
%%


%runs trials without updating weights
%records the paths that the rat takes

TRIALS2 = 100;
locInd=1;
placeCellHits = zeros(size(pc.x));
ratLocsX = zeros(1,TRIALS2*250);
ratLocsY = zeros(1,TRIALS2*250);
for trial = 1:TRIALS2
    
    % get rat's initial position. start each trial in a different quadrant
    rat = getInitLocation(trial);
    
    % let the rat explore for 100 time steps or until it gets reward
    t = 1;
    found_reward = 0;
    v = 0;
    a = zeros(1,8);
    
    % run for 100 moves or until a reward is found. whichever comes first
    while t <= 250 && ~found_reward;
        
        % choose an action and move rat to new location
        act = action_select (a, beta);
        rat = move (act, rat);
        
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
        
        [~,placeCellInd] = max(pc.act);
        placeCellHits(placeCellInd) = placeCellHits(placeCellInd)+1;
        
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
    
    trial
    
    latency(trial) = t;
end

figure
hold on
plot(ratLocsX,ratLocsY,'b.')
plot(rewards(:,1),rewards(:,2),'rx');
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
colorbar;