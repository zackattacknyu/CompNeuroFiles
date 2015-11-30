function [ rat ] = getRandLocation( minRad,maxRad )
%GETRANDLOCATION Summary of this function goes here
%   Detailed explanation goes here

    randRad = rand*(maxRad-minRad)+minRad;
    randAngle = rand*2*pi;
    complexPos = randRad*exp(randAngle*1i);
    rat.x = real(complexPos);
    rat.y = imag(complexPos);


end

