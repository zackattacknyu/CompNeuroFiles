function [ ] = graphErrors( xx,error )
%GRAPHERRORS This graphs angle versus population code error
%   
%   INPUT
%       xx - input angles
%       error - error direction in degrees

figure
plot(radtodeg(xx),radtodeg(error));
xlabel('Wind Direction (degrees)');
ylabel('Error (Degrees)');


end

