function [ skew ] = myskewness( X )
%MYSKEWNESS Summary of this function goes here
%   Detailed explanation goes here

lenX = length(X);
X(1:lenX/2)=-1*X(1:lenX/2);

numer = mean(X.^3);
denom = std(X)^3;

skew = numer/denom;

end

