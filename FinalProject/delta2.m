% delta rule for temporal difference learning
function y = delta(vnext, v, rwd)

y = rwd + vnext - v;

if(v>10)
   y=0; 
end
end