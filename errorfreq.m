function [terror]=errorfreq(freqn,error)
%entradas 
%   freq = array con las frecuencias normalizadas en la octava 1 existentes en la pieza de audio
%   error = array con las frecuencias erroneas dentro de una escala
errc=1;
terror=[];
for i=1:1:size(freqn')
    for j=1:1:size(error')
        if(isequal(round(freqn(1,i),3),round(error(1,j),3)))
            terror(1,errc)=i;
            errc=errc+1;
        end
    end
end