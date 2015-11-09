function [ skew ] = myskewness( X )
%MYSKEWNESS Calculates skewness for problem 2
%
%Because we wanted to figure out how much the values were skewed toward the
% left side rather than the right side, I decided to make all the left side
% values negative and the right side values positive. 
%
%I also made the mu value in the skewness equation 0 to further enforce the
% fact that we want to see how the values are skewed in favor of the left
% side
%

lenX = length(X);
X(1:lenX/2)=-1*X(1:lenX/2); %makes first 50 values negative

%{
Calculate skewness as per skewness.m code in Matlab except mu=0
%}
numer = mean(X.^3);
denom = std(X)^3;
skew = numer/denom;

end

