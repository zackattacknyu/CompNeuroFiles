%{
This is my code for problem 1.
We had neurons for the left and right eye and each neuron
    was connected to 100 v1 neurons
The strength of these neurons was initialized to be random numbers 
    and then we used the Hebbian plasticity rule to update the strengths
    depending on what the input of the neurons was

To simulate the firings, I used a mean firing rate network heavily inspired
    by jk_hw3_miniNet.m 
To update the weights due to plasticity, the plasiticty rule used was 
    the Hebbian rule in slide 16 of the 10-20 lecture notes. 
    I used this one so that there is some
    normalization done.

I decided that the input if the eyes are open would be a constant value and
    0 if the eyes are closed. This is because the kitten will be always be
    looking at something when the eye is open so it makes sense that there
    would be a constant input value. 
Also, by making sure open eyes have a constant value and closed eyes have a
    value of 0, the difference in OD factors will become more pronounced
    than if open eyes had random input values. 
%}


%{
As an initial case, both kitten's eyes are open, so it gets a stream of
    input from both eyes and this stream is equal. 
%}
inputRight = 0.5;
inputLeft = 0.5;

%this runs the model and obtains the OD factors
odFactor = getODfactors(inputRight,inputLeft);

figure
hist(odFactor,5);
title('Both eyes open OD factor graph');
xlabel('Number of Neurons');
ylabel('OD Category');

%{
The left eye is sutured shut, so its input is 0 while the right eye
    has a constant stream of input of 1
%}
inputRight = 1;
inputLeft = 0;

odFactor = getODfactors(inputRight,inputLeft);

figure
hist(odFactor,5);
title('Left eye sutured OD factor graph');
xlabel('Number of Neurons');
ylabel('OD Category');

%{
The right eye is sutured shut, so its input is 0 while the left eye
    has a constant stream of input of 1
%}
inputRight = 0;
inputLeft = 1;

odFactor = getODfactors(inputRight,inputLeft);

figure
hist(odFactor,5);
title('Right eye sutured OD factor graph');
xlabel('Number of Neurons');
ylabel('OD Category');