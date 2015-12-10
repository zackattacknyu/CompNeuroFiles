[rewards,~] = FINAL_getGeoRewards([8 12 13],0.5);

%rewards = [citiesLong citiesLat];
%reward_vals = citiesRew;
reward_vals = ones(size(rewards,1),1); %values for each reward, which decrease. 

%for European cities
rewardDecFactor = 0.95; %factor to decrease reward value by each time
rewardDecValue = 0;

epsilonThresh = 0.3;

%TRIALS =20;
TRIALS =50; %for European cities

[ w,z ] = FINAL_trainRat( rewards,reward_vals,...
    rewardDecFactor,rewardDecValue, TRIALS, epsilonThresh, 0 );

%runs trials without updating weights
%records the paths that the rat takes

%TRIALS2 = 15;
TRIALS2 = 50; %for European cities, 1

[ratPathsX,ratPathsY] = FINAL_testRat(z,TRIALS2);

%%

%Generates Figure 1
%Won't be exactly the same, but the same parameters were used
FINAL_make3figure( rewards,z,ratPathsX,ratPathsY )

%Generates Figure 2
%Won't be exactly the same, but the same parameters were used
FINAL_makeWfigure( w )

%%
FINAL_make2figure( rewards,z,ratPathsX,ratPathsY )

%%

[rewards,~] = FINAL_getGeoRewards([1 2 3 4 5],0.7);

%rewards = [citiesLong citiesLat];
%reward_vals = citiesRew;
reward_vals = ones(size(rewards,1),1); %values for each reward, which decrease. 

%for American cities
rewardDecFactor = 0.9; %factor to decrease reward value by each time
rewardDecValue = 0;

epsilonThresh = 0.2;

%TRIALS =20;
TRIALS =40; %for American cities

[ w,z ] = FINAL_trainRat( rewards,reward_vals,...
    rewardDecFactor,rewardDecValue, TRIALS, epsilonThresh, 0 );

%runs trials without updating weights
%records the paths that the rat takes

%TRIALS2 = 15;
TRIALS2 = 50; %for American cities, 1

[ratPathsX,ratPathsY] = FINAL_testRat(z,TRIALS2);

%Generates Figure 3
%Won't be exactly the same, but the same parameters were used
FINAL_make3figure( rewards,z,ratPathsX,ratPathsY )

%Generates Figure 4
%Won't be exactly the same, but the same parameters were used
FINAL_makeWfigure( w )

%%

[rewards,reward_vals] = FINAL_getGeoRewards([8 12 13],0.5);

rewardDecFactor = 1; %factor to decrease reward value by each time
rewardDecValue = 0.075;

epsilonThresh = 0.3;

TRIALS =20; %for American cities

[ w,z ] = FINAL_trainRat( rewards,reward_vals,...
    rewardDecFactor,rewardDecValue, TRIALS, epsilonThresh, 0 );

%runs trials without updating weights
%records the paths that the rat takes

TRIALS2 = 15; %for European cities, 2

[ratPathsX,ratPathsY] = FINAL_testRat(z,TRIALS2);

%Generates Figure 5
%Won't be exactly the same, but the same parameters were used
FINAL_make3figure( rewards,z,ratPathsX,ratPathsY )

%Generates Figure 6
%Won't be exactly the same, but the same parameters were used
FINAL_makeWfigure( w )

%%

[rewards,reward_vals] = FINAL_getGeoRewards([1 2 3 4 5],0.5);

rewardDecFactor = 1; %factor to decrease reward value by each time
rewardDecValue = 0.075;

epsilonThresh = 0.2;

TRIALS =15; %for American cities

[ w,z ] = FINAL_trainRat( rewards,reward_vals,...
    rewardDecFactor,rewardDecValue, TRIALS, epsilonThresh, 0 );

%runs trials without updating weights
%records the paths that the rat takes

TRIALS2 = 15; %for American cities, 2

[ratPathsX,ratPathsY] = FINAL_testRat(z,TRIALS2);

%Generates Figure 7
%Won't be exactly the same, but the same parameters were used
FINAL_make3figure( rewards,z,ratPathsX,ratPathsY )

%Generates Figure 8
%Won't be exactly the same, but the same parameters were used
FINAL_makeWfigure( w )

