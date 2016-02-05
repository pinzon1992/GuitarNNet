inputs = load(('TrainingInputs.txt'))'; %Obtencion Dataset
targets = load(('TrainingTargets.txt'))';

net = feedforwardnet(28);
net=init(net);
net.trainFcn = 'traingdx';
net.divideFcn = 'divideblock';
net.trainParam.epochs = 2000;
net.trainParam.lr = 0.02;
net.trainParam.mc = 0.8;
[net,tr] = train(net,inputs,targets);

%Iw = cell2mat(net.IW);
%b1 = cell2mat(net.b(1));
%Lw = cell2mat(net.Lw);
%b2 = cell2mat(net.b(2));