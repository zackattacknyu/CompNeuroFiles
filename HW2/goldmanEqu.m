%{
This plots the membrane potential values using the Goldman equation.
When the permeability ratio is 0.02 (time steps 1-44 and 56-100), 
    the membrane potential is around -75.7 mV
When the permeability ratio is 20 (time steps 45-55), 
    the membrane potential increases to around 40.13 mV
%}
goldman;

%{
Out of curiousity, I also plotted b value versus Em
    to see what the curve looks like. It is a smooth
    log curve as expected
%}
goldman2;