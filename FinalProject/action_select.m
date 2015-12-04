% choose an action based on the actor weights
function act = action_select (m, beta)

% get softmax probabilities
for i = 1:size(m,2)
    p(i) = exp(beta*m(i))/sum(exp(beta*m));
end

% choose an action based on the probability distribution
act = find(cumsum(p)>rand,1); %random selection

%{
sumprob = 0;
r = rand; % random number for action selection
i = 1;
act=i;
done = 0;
while ~done && i <= size(m,2)
    sumprob = sumprob + p(i);
    if sumprob > r
        act = i;
        done = 1;
    end
    i = i + 1;
end
%}
% disp ([r sumprob act p m])
end