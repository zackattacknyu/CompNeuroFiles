%{
This is the code that runs the model from my paper
and generates figures 1-8. When this code is run,
the figures won't be exactly the same but should come close.

Let me know if you want the data that generated the 
exact figures that are in my paper

The parameters of deprecitating factor or value, minimum threshold,
and number of trials were obtained via trial and error
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
This block of code is the run that generates figures 1 and 2
The European cities are used for the reward centers
The initial reward values are constant
Rewards are depreciated by a constant factor and not constant value
%}

clear all;

%function to retrieve our reward centers
%   cities 8,12,13 are the European ones
[rewards,~] = FINAL_getGeoRewards([8 12 13],0.5);

%constant initial rewards
reward_vals = ones(size(rewards,1),1); %values for each reward, which decrease. 

%constant depreciating factor of 0.95
rewardDecFactor = 0.95; 
rewardDecValue = 0;

%threshold before reward is unusable
epsilonThresh = 0.3;

TRIALS =50; %number of training trials
TRIALS2 = 50; %number of test trials

%run the training and obtain the actor and critic values
%   for each place cell
[ w,z ] = FINAL_trainRat( rewards,reward_vals,...
    rewardDecFactor,rewardDecValue, TRIALS, epsilonThresh, 0 );

%runs trials without updating weights
%records the paths that the rat takes
[ratPathsX,ratPathsY] = FINAL_testRat(z,TRIALS2);

%generates figure 1 approximately
FINAL_make3figure( rewards,z,ratPathsX,ratPathsY )

%Generates Figure 2 approximately
FINAL_makeWfigure( w )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
This block of code is the run that generates figures 3 and 4
The American cities are used for the reward centers
The initial reward values are constant
Rewards are depreciated by a constant factor and not constant value
%}

clear all;

%function to retrieve our reward centers
%   cities 1-5 are the American ones
[rewards,~] = FINAL_getGeoRewards([1 2 3 4 5],0.7);

%constant initial rewards
reward_vals = ones(size(rewards,1),1); %values for each reward, which decrease. 

%constant depreciating factor of 0.9
rewardDecFactor = 0.9; 
rewardDecValue = 0;

%threshold before reward is unusable
epsilonThresh = 0.2;

TRIALS =40; %number of training trials
TRIALS2 = 50; %number of test trials

%run the training and obtain the actor and critic values
%   for each place cell
[ w,z ] = FINAL_trainRat( rewards,reward_vals,...
    rewardDecFactor,rewardDecValue, TRIALS, epsilonThresh, 0 );

%runs trials without updating weights
%records the paths that the rat takes
[ratPathsX,ratPathsY] = FINAL_testRat(z,TRIALS2);

%generates figure 3 approximately
FINAL_make3figure( rewards,z,ratPathsX,ratPathsY )

%Generates Figure 4 approximately
FINAL_makeWfigure( w )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
This block of code is the run that generates figures 5 and 6
The European cities are used for the reward centers
The initial reward values are based on population
Rewards are depreciated by a constant value and not constant factor
%}

clear all;

%function to retrieve our reward centers and reward values
%   cities 8,12,13 are the European ones
[rewards,reward_vals] = FINAL_getGeoRewards([8 12 13],0.5);

%constant depreciating amount of 0.075
rewardDecFactor = 1; 
rewardDecValue = 0.075;

%threshold before reward is unusable
epsilonThresh = 0.3;

TRIALS =20; %number of training trials
TRIALS2 = 15; %number of test trials

%run the training and obtain the actor and critic values
%   for each place cell
[ w,z ] = FINAL_trainRat( rewards,reward_vals,...
    rewardDecFactor,rewardDecValue, TRIALS, epsilonThresh, 0 );

%runs trials without updating weights
%records the paths that the rat takes
[ratPathsX,ratPathsY] = FINAL_testRat(z,TRIALS2);

%generates figure 5 approximately
FINAL_make2figure( rewards,z,ratPathsX,ratPathsY )

%Generates Figure 6 approximately
FINAL_makeWfigure( w )


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
This block of code is the run that generates figures 7 and 8
The American cities are used for the reward centers
The initial reward values are based on population
Rewards are depreciated by a constant value and not constant factor
%}

clear all;

%function to retrieve our reward centers and reward values
%   cities 1-5 are the American ones
[rewards,reward_vals] = FINAL_getGeoRewards([1 2 3 4 5],0.5);

%constant depreciating amount of 0.075
rewardDecFactor = 1; 
rewardDecValue = 0.075;

%threshold before reward is unusable
epsilonThresh = 0.2;

TRIALS =15; %number of training trials
TRIALS2 = 15; %number of test trials

%run the training and obtain the actor and critic values
%   for each place cell
[ w,z ] = FINAL_trainRat( rewards,reward_vals,...
    rewardDecFactor,rewardDecValue, TRIALS, epsilonThresh, 0 );

%runs trials without updating weights
%records the paths that the rat takes
[ratPathsX,ratPathsY] = FINAL_testRat(z,TRIALS2);

%generates figure 7 approximately
FINAL_make2figure( rewards,z,ratPathsX,ratPathsY )

%Generates Figure 8 approximately
FINAL_makeWfigure( w )



