prefDir1=pi/4;
prefDir2=pi/2;
prefDir3=3*pi/4;
prefDir4=pi;

inputDir = pi*rand(1,1);

vNeuron1 = cos(prefDir1-inputDir);
vNeuron2 = cos(prefDir2-inputDir);
vNeuron3 = cos(prefDir3-inputDir);
vNeuron4 = cos(prefDir4-inputDir);

horizWeight = vNeuron1 + vNeuron2;
vertWeight = vNeuron3 + vNeuron4;
