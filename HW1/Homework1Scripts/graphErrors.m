function [ ] = graphErrors( xx,error )
%GRAPHERRORS This graphs angle versus population code error
%   
%   INPUT
%       xx - input angles
%       error - error direction in degrees

figure
plot(radtodeg(xx),radtodeg(error));
title('Error in Calculated Angle versus Wind Direction');
xlabel('Wind Direction (degrees)');
ylabel('Error (Degrees)');


end

