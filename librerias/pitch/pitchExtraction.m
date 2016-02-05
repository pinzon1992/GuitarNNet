%#function internal.IntervalTimer
function [t,freq]= pitchExtraction(file)

% Abre el archivo de audio:
[x,fs] = audioread(file);

% feature extraction:
Features = stFeatureExtraction(x, fs, 0.10, 0.020);

% Saca el pitch (23 feature):
F = Features(23,:);

% Calcula el vector de tiempo:
timeFeature = 0.020:0.020:length(x)/fs;

% post-process time vectors, sequence vector and signal vector:
MIN1 = min([length(F);length(timeFeature)]);
timeFeature = timeFeature(1:MIN1);
t=timeFeature;
F = F(1:MIN1);
freq=F;

plot(timeFeature, F);
hold on
grid on
xlabel('Time (sec)');
ylabel('Pitch (Hz)');
legend({'Estimado'}); 

