function [ ratPathsX, ratPathsY ] = FINAL_testRat(z, TRIALS2 )

%{
This takes in the actor weights and number of desired path
    trials and tests to see where the rat will travel.
It returns cell arrays with each entry being a list 
    of x or y coordinates in the path traversed by the rat
%}

global radius;
global obstacle;

%default parameter values from morris_water_maze.m
dirs = 8; % possible headings
beta = 2; % for softmax
obstacle = [1.0 1.0];

%sets up the circular water maze and place cells
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

ratLocsX = zeros(1,250);
ratLocsY = zeros(1,250);
ratPathsX = cell(1,TRIALS2);
ratPathsY = cell(1,TRIALS2);

for trial = 1:TRIALS2
    
    trial
    
    % get rat's initial position. 
    % start each trial in random spot
    rat = getRandLocation(0.1,0.9);
    
    t = 1;
    a = zeros(1,8);
    
    %rat moves for 100 time steps. 
    %no stopping for the reward. it just continues. 
    locInd=1;
    while t <= 100;
        
        % choose an action and move rat to new location
        act = action_select (a, beta);
        
        %Move rat based on action
        %NOTE: No adjustment of direction is made here
        rat = move2(act, rat);
        
        %record rat's current location
        ratLocsX(locInd)=rat.x;
        ratLocsY(locInd)=rat.y;
        locInd = locInd+1;
        
        % calculate the actor value
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
    
    %trim arrays
    ratLocsX = ratLocsX(1:(locInd-1));
    ratLocsY = ratLocsY(1:(locInd-1));
    
    %record path taken during trial
    ratPathsX{trial} = ratLocsX;
    ratPathsY{trial} = ratLocsY;
   
end

end

