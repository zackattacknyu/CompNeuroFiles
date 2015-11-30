function p = move(action, pos)

global radius;
global obstacle
speed = 0.1;

% get the heading of the agent based on the desired action
switch action
    case 1
        dir = 0;
    case 2
        dir = pi/4;
    case 3
        dir = pi/2;
    case 4
        dir = 3*pi/4;
    case 5
        dir = pi;
    case 6
        dir = 5*pi/4;
    case 7
        dir = 3*pi/2;
    case 8
        dir = 7*pi/4;
end

% get a new position for the agent
tmp.x = pos.x + speed*cos(dir);
tmp.y = pos.y + speed*sin(dir);

% check that the agent is within the boundaries of the arena. If it is not
% randomly shift the heading slightly until it is within bounds
while norm([tmp.x tmp.y]) > radius || norm([tmp.x tmp.y]-obstacle) < 0.5
    dir = dir + sign(rand-0.5)*pi/8;
    tmp.x = pos.x + speed*cos(dir);
    tmp.y = pos.y + speed*sin(dir);
end

p = tmp;
end
