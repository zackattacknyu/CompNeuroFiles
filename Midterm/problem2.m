clear all;

numCA3 = 100;

%parameters from izzynet code
aa = 0.02;
bb = 0.2;
cc = -65;
dd = 8;

% STDP lists for LTD and LTP weight changes
LTP = 0;    % from CA3 to CA1 neurons
LTD = zeros(1,numCA3);    % from CA3 to CA1 neurons

% STDP parameters
%A_plus = 0.1;
A_plus = 0.05;
A_minus = -0.105;
t_plus = 20;
t_minus = 20;

wmin = 0;
wmax = 5.0;

sigma=3;
maxCurrent = 30;

%CA1 neuron
v1 = cc;
u1 = bb*v1;

numFirings = zeros(1,100);


gaussWeights = normpdf(1:100,50,18);
gaussWeights = gaussWeights*(1/max(gaussWeights));
gaussWeights = gaussWeights*2;

%strength = 2*rand(1,numCA3);
strength = gaussWeights;

for step = 1:100
    
    %I1 = gaussWeights(step)*10;
   
    for t = 1:1000
        
        %CA1 neuron current
        % adds strengths of ones that fired
        I1 = strength(step)*20;
        
        
        %CA1 neuron voltage
        if(v1>=30)
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

            
            strength(step) = max(wmin,strength(step) + LTD(step)); % LTD to weights that connect to all exc from i
            LTD(step) = A_minus;  % set max LTD to i from all exc
            
        end
        
        strength(step) = min(wmax,strength(step) + LTP); % LTP to weights that connect to i from all exc 
        LTP = A_plus;   % set max LTP to all exc from i
        
        v1=v1+0.5*(0.04*v1^2+5*v1+140-u1+I1);
        v1=v1+0.5*(0.04*v1^2+5*v1+140-u1+I1);
        u1=u1+aa*(bb*v1-u1);
        
        
        
        % exponentially decay LTD and LTP based on time constants
        LTP = LTP - LTP/t_plus;
        LTD = LTD - LTD/t_minus;
        
    end
    
    
    
end

figure
plot(numFirings)

figure
plot(strength)