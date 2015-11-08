%{
This is my code for Problem 2

I used the Izhikevich spiking neuron model to replicate the moments when
the neurons spike. The STDP model is used to modify the synaptic connection
strength as the neuron fires.

The rat moves from location i to i+1 in each time step.
The rat does 17 laps from location 1 to 100
When the rat is at location i, the following happens:
1) Each CA3 is injected with an amount of current that depends on the
    Gaussian place field of the CA3 neurons
2) If a CA3 neuron spikes, then it sends a signal to the CA1 neuron. 
    The LTD of the CA3->CA1 synapse is updated and the LTP is reset
3) For the CA1 neuron, a current is injected that is dependent on which
    synaptic connections spiked
4) If the CA1 neuron spikes, then the LTP of all the CA3->CA1 neurons are
    updated and their LTD is reset

%}

%number of laps the rat will do
numLaps = 17;

%this is the number of CA3 neurons
numCA3 = 100;

%these are the a,b,c,d parameters in the Izhikevich model
%the default parameters from the class model worked well
aa = 0.02;
bb = 0.2;
cc = -65;
dd = 8;

%{
These are the STDP parameters.
Most of the default parameters worked well, however I changed
    the wmax parameter in order to allow stronger synaptic strengths.
This was done to allow more current to flow and thus increase the number of
    spikes that occur. 
By allowing more spiking, it was much easier to see the difference in
    number of spikes in the center versus on the edge
%}
A_plus = 0.1;
A_minus = -0.105;
t_plus = 20;
t_minus = 20;
wmin = 0;
wmax = 20.0; %this was changed from a value of 5

%{
Here are the parameters that control the place fields and synpatic
    strengths

Let N be the number of CA3 neurons
The CA3 neurons are at location 1,2,3,...,N
The current injected by a given CA3 neuron at location i is a gaussian
    centered at i

The synaptic strength of the CA3 to CA1 neuron connections is a gaussian
    centered at N/2
%}

%{
These two parameters control the Gaussian for synaptic strength. I made
    sure the maximum strength is equal to the maximum in the STDP model so
    that the center starts off as strong as possible. 
I also used a small sigma value so that the center is very strong compared
    to the other synpases. 
In this way, the initial preference toward firing when the rat is in the center is
    as great as possible within the model. 
%}
maxInitWeight = wmax; %value for peak of Gaussian curve
sigmaStrength = 3; %sigma for strength Gaussian curve

%{
These two parameters are used to adjust the place field Gaussians. 
I wanted to make sure that if a rat is at location i, then neuron i will
    fire. I thus made the max current very high in the Gaussian curve. This
    way there is quite a high chance of spiking in the Izhikevich model.
I kept the sigma relatively low so that there is a low chance of the
    neighboring neurons spiking when the rat is at location i. 
%}
maxInitCurrent = 80; %max current injected by Gaussian place field
sigma=2; %sigma for place field Gaussians


%{
The parameters that can vary in the model have now been established.
The rest of the code is used for running the model
    and generating the graphs of the results.
%}

% STDP lists for LTD and LTP weight changes
% they represent strength changes for the CA3 to CA1 synaptic connections
LTP = zeros(1,numCA3); 
LTD = zeros(1,numCA3);    

%{
As a coding preference, I keep track of the voltages and recovery variables 
    for the CA3 and CA1 neurons separately. 
%}

%voltage and recovery variable for CA1 neurons
v1 = cc;
u1 = bb*v1;

%voltages and recovery variables for CA1 neurons
vv = cc.*ones(1,numCA3);
uu = bb.*vv;



%Here I initialize the synaptic strengths of the CA3 to CA1 connections
gaussWeights = normpdf(1:numCA3,numCA3/2,sigmaStrength); %generates the Gaussian values
gaussWeights = gaussWeights*(1/max(gaussWeights)); %sets max value to 1
strength = gaussWeights*maxInitWeight; %sets max value to our desired maximum
initStrength = strength; %saves initial value for later graph

%used to keep track of the skewness values for later graph
inputSkewValues = zeros(1,numLaps);
outputSkewValues = zeros(1,numLaps);

%used to keep track of first and last spike time for later graph
firstSpikeTime = zeros(1,numLaps);
lastSpikeTime = zeros(1,numLaps);

%keeps track of number of times each CA3 neuron fired for later graph
numFirings = zeros(1,numCA3);

for lap = 1:numLaps
    
    for step = 1:numCA3
        
        I = normpdf(step,1:numCA3,sigma);
        I = I/(max(I)); %sets max to 1
        I = I*maxInitCurrent; %sets max current to 30 so neuron will fire
        
        %I1 = gaussWeights(step)*10;
        
        %update CA3 neuron voltages
        vv=vv+0.5.*(0.04.*vv.^2+5.*vv+140-uu+I);
        vv=vv+0.5.*(0.04.*vv.^2+5.*vv+140-uu+I);
        uu=uu+aa.*(bb.*vv-uu);

        fired = find(vv>=30);

        %CA1 neuron current
        % adds strengths of ones that fired
        % NOTE: ADD OSCILLATORY INPUT
        I1 = -1*abs(real(exp(1i*step*pi/8))) + sum(strength(fired));
        
        %update CA3 neurons that fired
        if ~isempty(fired)
            vv(fired)=cc;
            uu(fired)=uu(fired)+dd;
                
            % if neuron i is excitatory
            % 1)    apply LTP for weights that connect to neuron i 
            %       (i.e., the neurons that fired prior to i)  
            % 2)    apply LTD for weights from neuron i 
            %       (i.e., the neurons that i fired before) 
            % 3)    set the max LTP for  weights that connect from neuron i
            % 4)    set the max LTD for weights that connect to neuron i

            strength(fired) = max(wmin,strength(fired) + LTD(fired)); % LTP to weights that connect to i from all exc 
            LTP(fired) = A_plus;

            
        end;
        
        %update CA1 neuron voltages
        v1=v1+0.5*(0.04*v1^2+5*v1+140-u1+I1);
        v1=v1+0.5*(0.04*v1^2+5*v1+140-u1+I1);
        u1=u1+aa*(bb*v1-u1);


        %CA1 neuron voltage
        if(v1>=30)
            
            if(firstSpikeTime(lap) < 1)
               firstSpikeTime(lap)=step; 
            end
            lastSpikeTime(lap)=step;
            
            v1 = cc;
            u1 = u1+dd;
            numFirings(step) = numFirings(step)+1;

            % if neuron i is excitatory
            % 1)    apply LTP for weights that connect to neuron i 
            %       (i.e., the neurons that fired prior to i)  
            % 2)    apply LTD for weights from neuron i 
            %       (i.e., the neurons that i fired before) 
            % 3)    set the max LTP for  weights that connect from neuron i
            % 4)    set the max LTD for weights that connect to neuron i

            strength = min(wmax,strength + LTP); % LTP to weights that connect to i from all exc 
            LTD(:) = A_minus;

        end

        % exponentially decay LTD and LTP based on time constants
        LTP = LTP - LTP/t_plus;
        LTD = LTD - LTD/t_minus;

    end
    
    if(lap<2)

        numInitFirings = numFirings;
        
        
    end
    
    inputSkewValues(lap) = myskewness(strength);
    outputSkewValues(lap) = myskewness(numFirings);
    
end


figure
hold on
title('Strength Before and After Experience (replication of 4a)')
plot(initStrength,'r-');
plot(strength,'b-');
legend('Strength Before Experience','Strength After Experience');
hold off

figure
hold on
title('Firing Rate Before and After Experience (replication of 4b)');
plot(numInitFirings,'r-');
plot(numFirings,'b-');
hold off
legend('Number of Firings before Experience','Number of Firings After Experience');

figure
hold on
title('Skewness Values (replication of 4d)');
plot(inputSkewValues,'b-')
plot(outputSkewValues,'r-')
legend('Input Skewness','Output Skewness','Location','eastoutside')
hold off


figure
hold on
title('Spike Times (replication of 4e)');
plot(firstSpikeTime,'b-')
plot(lastSpikeTime,'r-')
hold off
