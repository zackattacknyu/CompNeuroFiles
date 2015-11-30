% delta rule for temporal difference learning
function y = delta(vnext, v, rwd)

y = rwd + vnext - v;
end