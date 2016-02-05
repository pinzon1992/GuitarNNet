%clear all
%clc
function [coeffs,t,fq,fqn] = bsefreqtry(file)
ref = load('octavebase.txt'); %Carga las frecuencias de referencia de la octava base.
[t,f]=pitchExtraction(file); %Obtiene las frecuencias existentes en el archivo de audio.
test0 = f';
ntest = size(test0);
fq=f;
a = test0;
Cbase=32.7031956626; %La frecuencia de la nota C en la octava base.

%Calcula la frecuencia del pitch al que es equivalente cada nota en octava
%base
for i=1:1:ntest
    semitones=round(mod(12*log2(a(i)/Cbase),12));
    a(i)=(2^(semitones/12))*Cbase;
end
new_a=a';
fqn = new_a;
%Calcula el numero de ocurrencias de cada pitch y sus respectivas
%probabilidades en la secuencia musical.
count=zeros(1,12);
for i=1:1:12
    for j=1:1:ntest
        if isequal(round(new_a(1,j)),round(ref(1,i)))
            count(1,i)=count(1,i)+1;
        end
    end
end
probs = count/sum(count);   %Calcula la probabilidad(factor de ocurrencia) de cada pitch.

%Los siguiente vectores son las perfiles de clave de cada scala/clave.

keyprofile_c=[6.35	2.23	3.48	2.33	4.38	4.09	2.52	5.19	2.39	3.66	2.29	2.88];
keyprofile_csharp=[2.88	6.35	2.23	3.48	2.33	4.38	4.09	2.52	5.19	2.39	3.66	2.29];
keyprofile_d=[2.29	2.88	6.35	2.23	3.48	2.33	4.38	4.09	2.52	5.19	2.39	3.66];
keyprofile_dsharp=[3.66	2.29	2.88	6.35	2.23	3.48	2.33	4.38	4.09	2.52	5.19	2.39];
keyprofile_e=[2.39	3.66	2.29	2.88	6.35	2.23	3.48	2.33	4.38	4.09	2.52	5.19];
keyprofile_f=[5.19	2.39	3.66	2.29	2.88	6.35	2.23	3.48	2.33	4.38	4.09	2.52];
keyprofile_fsharp=[2.52	5.19	2.39	3.66	2.29	2.88	6.35	2.23	3.48	2.33	4.38	4.09];
keyprofile_g=[4.09	2.52	5.19	2.39	3.66	2.29	2.88	6.35	2.23	3.48	2.33	4.38];
keyprofile_gsharp=[4.38	4.09	2.52	5.19	2.39	3.66	2.29	2.88	6.35	2.23	3.48	2.33];
keyprofile_a=[2.33	4.38	4.09	2.52	5.19	2.39	3.66	2.29	2.88	6.35	2.23	3.48];
keyprofile_asharp=[3.48	2.33	4.38	4.09	2.52	5.19	2.39	3.66	2.29	2.88	6.35	2.23];
keyprofile_b=[2.23	3.48	2.33	4.38	4.09	2.52	5.19	2.39	3.66	2.29	2.88	6.35];

keyprofile_aminor=[5.38	  2.6	3.53	2.54	4.75	3.98	2.69	3.34	3.17	6.33	2.68	3.52];
keyprofile_asharpminor=[3.52	5.38	2.6	3.53	2.54	4.75	3.98	2.69	3.34	3.17	6.33	2.68];
keyprofile_bminor=[2.68	3.52	5.38	2.6	3.53	2.54	4.75	3.98	2.69	3.34	3.17	6.33];
keyprofile_cminor=[6.33	2.68	3.52	5.38	2.6	3.53	2.54	4.75	3.98	2.69	3.34	3.17];
keyprofile_csharpminor=[3.17	6.33	2.68	3.52	5.38	2.6	3.53	2.54	4.75	3.98	2.69	3.34];
keyprofile_dminor=[3.34	3.17	6.33	2.68	3.52	5.38	2.6	3.53	2.54	4.75	3.98	2.69];
keyprofile_dsharpminor=[2.69	3.34	3.17	6.33	2.68	3.52	5.38	2.6	3.53	2.54	4.75	3.98];
keyprofile_eminor=[3.98	2.69	3.34	3.17	6.33	2.68	3.52	5.38	2.6	3.53	2.54	4.75];
keyprofile_fminor=[4.75	3.98	2.69	3.34	3.17	6.33	2.68	3.52	5.38	2.6	3.53	2.54];
keyprofile_fsharpminor=[2.54	4.75	3.98	2.69	3.34	3.17	6.33	2.68	3.52	5.38	2.6	3.53];
keyprofile_gminor=[3.53	2.54	4.75	3.98	2.69	3.34	3.17	6.33	2.68	3.52	5.38	2.6];
keyprofile_gsharpminor=[2.6	3.53	2.54	4.75	3.98	2.69	3.34	3.17	6.33	2.68	3.52	5.38];

N=12;
coeff_majors = zeros(1,12);
coeff_minors=zeros(1,12);

%Calcula los co-effecients de correlacion de la pieza musical con los
%perfiles de clave

coeff_majors(1,1)=(1/(N-1))*(keyprofile_c*probs'-12*mean(keyprofile_c)*mean(probs))/(std(keyprofile_c)*std(probs));
coeff_majors(1,2)=(1/(N-1))*(keyprofile_csharp*probs'-12*mean(keyprofile_csharp)*mean(probs))/(std(keyprofile_csharp)*std(probs));
coeff_majors(1,3)=(1/(N-1))*(keyprofile_d*probs'-12*mean(keyprofile_d)*mean(probs))/(std(keyprofile_d)*std(probs));
coeff_majors(1,4)=(1/(N-1))*(keyprofile_dsharp*probs'-12*mean(keyprofile_dsharp)*mean(probs))/(std(keyprofile_dsharp)*std(probs));
coeff_majors(1,5)=(1/(N-1))*(keyprofile_e*probs'-12*mean(keyprofile_e)*mean(probs))/(std(keyprofile_e)*std(probs));
coeff_majors(1,6)=(1/(N-1))*(keyprofile_f*probs'-12*mean(keyprofile_f)*mean(probs))/(std(keyprofile_f)*std(probs));
coeff_majors(1,7)=(1/(N-1))*(keyprofile_fsharp*probs'-12*mean(keyprofile_fsharp)*mean(probs))/(std(keyprofile_fsharp)*std(probs));
coeff_majors(1,8)=(1/(N-1))*(keyprofile_g*probs'-12*mean(keyprofile_g)*mean(probs))/(std(keyprofile_g)*std(probs));
coeff_majors(1,9)=(1/(N-1))*(keyprofile_gsharp*probs'-12*mean(keyprofile_gsharp)*mean(probs))/(std(keyprofile_gsharp)*std(probs));
coeff_majors(1,10)=(1/(N-1))*(keyprofile_a*probs'-12*mean(keyprofile_a)*mean(probs))/(std(keyprofile_a)*std(probs));
coeff_majors(1,11)=(1/(N-1))*(keyprofile_asharp*probs'-12*mean(keyprofile_asharp)*mean(probs))/(std(keyprofile_asharp)*std(probs));
coeff_majors(1,12)=(1/(N-1))*(keyprofile_b*probs'-12*mean(keyprofile_b)*mean(probs))/(std(keyprofile_b)*std(probs));


coeff_minors(1,1)=(1/(N-1))*(keyprofile_aminor*probs'-12*mean(keyprofile_aminor)*mean(probs))/(std(keyprofile_aminor)*std(probs));
coeff_minors(1,2)=(1/(N-1))*(keyprofile_asharpminor*probs'-12*mean(keyprofile_asharpminor)*mean(probs))/(std(keyprofile_asharpminor)*std(probs));
coeff_minors(1,3)=(1/(N-1))*(keyprofile_bminor*probs'-12*mean(keyprofile_bminor)*mean(probs))/(std(keyprofile_bminor)*std(probs));
coeff_minors(1,4)=(1/(N-1))*(keyprofile_cminor*probs'-12*mean(keyprofile_cminor)*mean(probs))/(std(keyprofile_cminor)*std(probs));
coeff_minors(1,5)=(1/(N-1))*(keyprofile_csharpminor*probs'-12*mean(keyprofile_csharpminor)*mean(probs))/(std(keyprofile_csharpminor)*std(probs));
coeff_minors(1,6)=(1/(N-1))*(keyprofile_dminor*probs'-12*mean(keyprofile_dminor)*mean(probs))/(std(keyprofile_dminor)*std(probs));
coeff_minors(1,7)=(1/(N-1))*(keyprofile_dsharpminor*probs'-12*mean(keyprofile_dsharpminor)*mean(probs))/(std(keyprofile_dsharpminor)*std(probs));
coeff_minors(1,8)=(1/(N-1))*(keyprofile_eminor*probs'-12*mean(keyprofile_eminor)*mean(probs))/(std(keyprofile_eminor)*std(probs));
coeff_minors(1,9)=(1/(N-1))*(keyprofile_fminor*probs'-12*mean(keyprofile_fminor)*mean(probs))/(std(keyprofile_fminor)*std(probs));
coeff_minors(1,10)=(1/(N-1))*(keyprofile_fsharpminor*probs'-12*mean(keyprofile_fsharpminor)*mean(probs))/(std(keyprofile_fsharpminor)*std(probs));
coeff_minors(1,11)=(1/(N-1))*(keyprofile_gminor*probs'-12*mean(keyprofile_gminor)*mean(probs))/(std(keyprofile_gminor)*std(probs));
coeff_minors(1,12)=(1/(N-1))*(keyprofile_gsharpminor*probs'-12*mean(keyprofile_gsharpminor)*mean(probs))/(std(keyprofile_gsharpminor)*std(probs));

coeffs = (coeff_majors+coeff_minors)/2; %co-effecients finales.