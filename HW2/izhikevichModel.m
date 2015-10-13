%shows the firing rate in the 0-4 nA range
%   class 2 excitable neuron begins firing around 0.4 nA
%       and then starts firing quite quickly
%   the class 1 excitable neuron does not fire at all in this range
%   the regular spiking neuron barely starts firing in this range
izhevichPlots(0:0.01:4);

%shows the firing rate in the 0-20 nA range
%   The class 2 excitable neuron begins firing at a low current
%       and fires much faster as current increases than the others
%   The class 1 excitable neuron does not begin firing rate
%   The regular spiking neuron begins to fire
izhevichPlots(0:0.1:20);

%shows the firing rates in the 0-100 nA range
%   The class 2 excitable neuron reaches the maximal firing
%       rate of 2000 Hz measurable via our method after around 50 nA.
%   The class 1 excitable neuron does not firing until around 22 nA
%       and then increasing its firing rate relatively linearly
%   The regular spiking neuron starts firing with a current of around 3 nA
%       and increasing its firing rate linearly at first, then
%       increasing in a more step-like manner
izhevichPlots(0:1:100);

%shows the firing rates in the 0-800 nA range
%   after about 600 nA, all the neurons reach 
%   the maximal firing rate we can calculate
izhevichPlots(0:10:800);



