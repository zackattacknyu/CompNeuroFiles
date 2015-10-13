%shows the frequency vs current in the 0-4 nA range
%   the neuron starts firing at 1.5 nA and the firing rate increases
%   rapidly at first, followed by increasing in a step-like manner
ifNeuronPlot( 0:0.05:4 );

%shows the frequency vs current in the 0-20 nA range
%   The firing rate increases in a step-like manner with the steps
%   growing larger and larger. At 16 nA, it reaches the maximal
%   firing rate of 2000 Hz that we can calculate
ifNeuronPlot( 0:.1:20 );
