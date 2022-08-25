function []=linha()
%CENTRO FEDERAL DE EDUCACAO TECNOLOGICA CELSO SUCKOW DA FONSECA
%TRABALHO DE LINHAS DE TRANSMISSAO
%CÁLCULO DOS PARAMETROS DE LINHA DE TRANSMISSÃO
%Alunos: Felipe Gonçalves e Vítor Barbosa

clear all
clc
format short

%%%%%%%%%%%%%%%%%%% 1 - CALCULO DA MATRIZ DE IMPEDANCIAS %%%%%%%%%%%%%%%%%%
% 1.1 - DADOS DE ENTRADA
% 1.1.1 - Dados Gerais:
Vb=345*10^3; %Tensao da Linha em kV;
Pmax = 699*10^6; %Potencia maxima em MVA ;
f=60; %Frequencia da rede em Hertz;
Llinha=231100; %Comprimento da linha em metros;
w=2*pi*f; %Velocidade angular;
rext=0.012575; %raio externo do condutor em metros;
rint=0.004635; %raio interno do condutor fase em metros;
rmg = 0.01021; %raio medio geometrico em metros;
pmag=4*pi*10^(-7); %permeabilidade magnetica no vacuo(H/m);
r_solo = 1000; %resistividade do solo (ohm.m);
ro=3.432*10^(-8); %resistividade do aluminio a 75ºC(ohm.m);
cond=1/ro; %condutividade do aluminio a 75ºC;

% 1.1.2 - Dados das posições dos condutores:
cond_a = [0,41.2];
cond_b = [8.5,42.25];
cond_c = [17,41.2];

% 1.2 - CALCULO DA IMPEDANCIA INTERNA DOS CABOS FASE:
s = rint/rext; %razao entre raio interndo e externo do condutor.
Rdc_alum = 0.2594*10^(-3); %resistencia do aluminio a 75ºC a corrente continua (ohm/m).
m = sqrt(w*pmag*cond); %variável usada na serie modificada de Bessel;
phi =(besseli(1,m*rint*sqrt(j)))/(besselk(1,m*rint*sqrt(j)));
W =(besseli(0,m*rext*sqrt(j))+phi*(besselk(0,m*rext*sqrt(j))))/((sqrt(j)*besseli(1,m*rext*sqrt(j)))+phi*(-sqrt(j)*(besselk(1,m*rext*sqrt(j)))));
Z_int = Rdc_alum*(j/2)*m*rext*(1-s^2)*W; %Impedancia Interna dos condutores fase (ohm/m).

% 1.3 - CALCULO DA IMPEDANCIA TOTAL:
% 1.3.1 - Criacao de uma matriz das razoes das distancias entre condutores considerando a profundidade complexa:
P = sqrt(r_solo/(j*w*pmag)); %profundidade complexa.
D = zeros(3);
D(1,1) = (2*(cond_a(1,2)+P))/rmg;
D(2,2) = (2*(cond_b(1,2)+P))/rmg;
D(3,3) = (2*(cond_c(1,2)+P))/rmg;
D(1,2) =(sqrt((cond_a(1,2)+cond_b(1,2)+2*P)^2+(cond_b(1,1)-cond_a(1,1))^2))/(sqrt((abs(cond_b(1,2)-cond_a(1,2)))^2+(cond_b(1,1)-cond_a(1,1))^2));
D(1,3) =(sqrt((cond_a(1,2)+cond_c(1,2)+2*P)^2+(cond_c(1,1)-cond_a(1,1))^2))/(sqrt((abs(cond_c(1,2)-cond_a(1,2)))^2+(cond_c(1,1)-cond_a(1,1))^2));
D(2,3) =(sqrt((cond_b(1,2)+cond_c(1,2)+2*P)^2+(cond_c(1,1)-cond_b(1,1))^2))/(sqrt((abs(cond_c(1,2)-cond_b(1,2)))^2+(cond_c(1,1)-cond_b(1,1))^2));
D(2,1) = D(1,2);
D(3,1) = D(1,3);
D(3,2) = D(2,3);

% 1.3.2 - Construcao da matriz de impedancias total(ohm/km):
Z = zeros(3);
  for cont1=1:3
   for cont2=1:3
     if(cont1==cont2)
     Z(cont1,cont2) = Z_int*1000 + j*w*2*10^(-4)*log(D(cont1,cont2));
     else
     Z(cont1,cont2) = j*w*2*10^(-4)*log(D(cont1,cont2));
     end
   end
  end

% 1.4 - CALCULO DA MATRIZ DE IMPEDANCIAS TRANSPOSTA:
Zp = (Z(1,1)+Z(2,2)+Z(3,3))/3; %impedancia propria.
Zm =(Z(1,2)+Z(1,3)+Z(2,3))/3; %impedancia mutua.
Z_transp = [Zp,Zm,Zm;Zm,Zp,Zm;Zm,Zm,Zp]; %Matriz de impedancias com linha transposta.

% 1.5 - CALCULO DA MATRIZ DE COMPONENTES DE SEQUENCIA:
T = [1,1,1; 1,-0.5-0.866*j,-0.5+0.866*j; 1, -0.5+0.866*j,-0.5-0.866*j]; %Matriz de transformacao.
T_inv = inv(T); %Matriz de transformacao inversa.
Z_seq = T_inv*Z_transp*T %Matriz de componentes de sequencia.


%%%%%%%%%%%%%%%%% 2 - CÁLCULO DA MATRIZ DE CAPACITANCIAS %%%%%%%%%%%%%%%%%%
% 2.1 - Criação da matriz com a razao das distancias entre condutores:
D(1,1) = (2*cond_a(1,2))./rext;
D(2,2) = (2*cond_b(1,2))./rext;
D(3,3) = (2*cond_c(1,2))./rext;
D(1,2) = (sqrt((cond_a(1,2)+cond_b(1,2))^2+(cond_b(1,1)- cond_a(1,1))^2))./(sqrt((abs(cond_b(1,2)-cond_a(1,2)))^2+(cond_b(1,1)-cond_a(1,1))^2));
D(1,3) = (sqrt((cond_a(1,2)+cond_c(1,2))^2+(cond_c(1,1)- cond_a(1,1))^2))./(sqrt((abs(cond_c(1,2)- cond_a(1,2)))^2+(cond_c(1,1)-cond_a(1,1))^2));
D(2,3) = (sqrt((cond_b(1,2)+cond_c(1,2))^2+(cond_c(1,1)- cond_b(1,1))^2))./(sqrt((abs(cond_c(1,2)- cond_b(1,2)))^2+(cond_c(1,1)-cond_b(1,1))^2));
D(2,1) = D(1,2);
D(3,1) = D(1,3);
D(3,2) = D(2,3);

% 2.2 - Calculo da matriz de coeficientes de potenciais de Maxwell (km/MicroF):
MP = zeros(3);
for cont1=1:3
 for cont2=1:3
 MP(cont1,cont2) = 17.98*log(D(cont1,cont2));
 end
end

% 2.3 - Calculo da matriz de capacitancias (nanoF/km):
C = inv(MP)*1000;
% 2.4 - Calculo da transposta da matriz de capacitancias:
Cp = (C(1,1)+C(2,2)+C(3,3))/3;
Cm =(C(1,2)+C(1,3)+C(2,3))/3;
C_transp = [Cp,Cm,Cm;Cm,Cp,Cm;Cm,Cm,Cp];

% 2.5 - Calculo das componentes de sequencia (nanoF/km):
C_seq = T_inv*C_transp*T

%%%%%%%%%%%%%%%%% 3.1 CALCULO DAS CONSTANTES DE QUADRIPOLO %%%%%%%%%%%%%%%%%
Zkm=Z_seq(1,1)
Ykm=C_seq(1,1)

Zc=sqrt(Zkm./Ykm)

gama=sqrt((Zkm./Llinha)*(Ykm./Llinha))

paramA=cosh(gama*Llinha)
paramB=Zc*sinh(gama*Llinha)
paramC=sinh(gama*Llinha)./Zc
paramD=paramA


%%%%%%%%%%%%%%%%% 4.1 CALCULO CAPACIDADE MAXIMA DE POTENCIA %%%%%%%%%%%%%%%%%
Vr=Vb./sqrt(3);
Ir=Pmax./(Vb*sqrt(3));
Vs=(Vr*paramA)+(Ir*paramB)

modVs=abs(Vs);
angVs=angle(Vs)*57.2958;
modVr=abs(Vr);
angVr=angle(Vr)*57.2958;
modA=abs(paramA);
angA=angle(paramA)*57.2958;
modB=abs(paramB);
angB=angle(paramB)*57.2958;

Cmaxp=((modVs*modVr)./modB)-(((modA*modVr*modVr)./modB)*cos(angA-angB))

% 4.2 CALCULO CAPACIDADE MAXIMA DE POTENCIA COMPENSADA EM 30%:
Xc=modB-(modB./1.3);

Cmaxpcomp=((modVs*modVr)./(modB-Xc))-(((modA*modVr*modVr)./(modB-Xc))*cos(angA-angB))

Ccomp=1./(2*pi*f*Xc)
end
