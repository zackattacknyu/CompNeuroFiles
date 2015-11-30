function [ rat ] = getInitLocation(trial  )
%GETINITLOCATION Summary of this function goes here
%   Detailed explanation goes here

initMag=0.1;
    if mod(trial,4) == 1
        rat.x = -initMag;
        rat.y = 0;
    elseif mod(trial,4) == 2
        rat.x = 0;
        rat.y = initMag;
    elseif mod(trial,4) == 3
        rat.x = initMag;
        rat.y = 0;
    else
        rat.x = 0;
        rat.y = -initMag;
    end
end

