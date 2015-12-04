function [ act ] = adjustAct( prevAct,curAct )
%ADJUSTACT Summary of this function goes here
%   Detailed explanation goes here

if(prevAct==curAct)
   act = curAct;
end

curAngle = curAct*pi/4;
prevAngle = prevAct*pi/4;

%right or left move is determined by sign of sin
rightLeft = sign(sin(curAngle-prevAngle));
if(rightLeft==1)
   act = mod(prevAct+1,8)+1;
elseif(rightLeft==-1)
    act = mod(prevAct-1,8)+1;
else
    act = curAct;
end

end

