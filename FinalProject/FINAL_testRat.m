function [ ratPathsX, ratPathsY ] = FINAL_testRat(z, TRIALS2 )
%FINAL_TESTRAT Summary of this function goes here
%   Detailed explanation goes here

global radius;
global obstacle;

%default parameter values from morris_water_maze.m
dirs = 8; % possible headings
beta = 2; % for softmax
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

obstacle = [1.0 1.0];

ratLocsX = zeros(1,250);
ratLocsY = zeros(1,250);
ratPathsX = cell(1,TRIALS2);
ratPathsY = cell(1,TRIALS2);
for trial = 1:TRIALS2
    
    trial
    
    % get rat's initial position. start each trial in a different quadrant
    rat = getRandLocation(0.1,0.9);
    
    % let the rat explore for 100 time steps or until it gets reward
    t = 1;
    a = zeros(1,8);
    
    % run for 100 moves or until a reward is found. whichever comes first
    locInd=1;
    while t <= 100;
        
        % choose an action and move rat to new location
        act = action_select (a, beta);
        %act = adjustAct(act,prevAct); %abandoned other action here
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
        
        t = t + 1;
        
        
        

    end
    
    ratLocsX = ratLocsX(1:(locInd-1));
    ratLocsY = ratLocsY(1:(locInd-1));
    ratPathsX{trial} = ratLocsX;
    ratPathsY{trial} = ratLocsY;
   
end

end

