function [ rat ] = getRandLocation2( minRad,maxRad )
%GETRANDLOCATION Summary of this function goes here
%   Detailed explanation goes here

    rat.x = rand*(maxRad-minRad)+minRad;
    rat.y = rand*(maxRad-minRad)+minRad;
    


end

