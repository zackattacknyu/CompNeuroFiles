clear all;

%number of CA3 neurons
numCA3 = 100;

%parameters from izzynet code
aa = 0.02;
bb = 0.2;
cc = -65;
dd = 8;

% STDP lists for LTD and LTP weight changes
LTP = zeros(1,numCA3);    % from CA3 to CA1 neurons
LTD = zeros(1,numCA3);    % from CA3 to CA1 neurons

% STDP parameters
A_plus = 0.1;
A_minus = -0.105;
t_plus = 20;
t_minus = 20;

wmin = 0;
%wmax = 5.0;
wmax = 20.0;

sigma=2; %sigma for place field Gaussians
sigmaStrength = 3; %sigma for strength Gaussian curve

maxCurrent = 30;

%CA1 neuron
v1 = cc;
u1 = bb*v1;

%CA3 neurons
numFirings = zeros(1,100);

%maximum initial weight
maxInitWeight = wmax;

%max init current for CA3 neurons
% makes sure it fires with Iz model if this amount of current is injected
maxInitCurrent = 80;


gaussWeights = normpdf(1:100,50,sigmaStrength);
gaussWeights = gaussWeights*(1/max(gaussWeights)); %sets max to 1
strength = gaussWeights*maxInitWeight;
%strength = gaussWeights*100;
%strength = gaussWeights*wmax;

vv = -65*ones(1,numCA3);
uu = bb.*vv;

numLaps = 17;
skewValues = zeros(1,numLaps);

firstSpikeTime = zeros(1,numLaps);
lastSpikeTime = zeros(1,numLaps);

for lap = 1:numLaps
    
    %LTP = zeros(1,numCA3);    % from CA3 to CA1 neurons
    %LTD = zeros(1,numCA3);    % from CA3 to CA1 neurons
    
    for step = 1:100
        
        I = normpdf(step,1:100,sigma);
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
        I1 = abs(2*randn(1,1)) + sum(strength(fired));
        
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
    
        figure
        plot(numFirings)
        
        
    end
    
    skewValues(lap) = skewness(strength);
end

figure
plot(numFirings)

%figure
%plot(strength)
%%
figure
plot(skewValues)

%%


figure
hold on
plot(firstSpikeTime,'b-')
plot(lastSpikeTime,'r-')
hold off
