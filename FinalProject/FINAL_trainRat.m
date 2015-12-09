function [ w,z ] = FINAL_trainRat( pc,rewards,reward_vals,...
    rewardDecFactor,rewardDecValue, TRIALS, epsilonThresh, drawGraph )
%FINAL_TRAINRAT Summary of this function goes here
%   Detailed explanation goes here
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
                reward_vals
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

    
    if(mod(trial,1)==0 && drawGraph)
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

end

