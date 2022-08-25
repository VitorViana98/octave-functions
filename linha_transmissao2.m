function [] =linha_transmissao()
  close all
  clear all
  clc

  wk=0.12134;
  rd=0.0592;
%  rd=0.0015;
  a=-0.5+i*0.866025403;
  A=[1,1,1;1,a^2,a;1,a,a^2];
  Ainv=(1./3)*A;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% Linha Pimenta - Barbacena
  %% Tensao 345 kV / Comprimento 231.1 km / Potencia Maxima = 699 MVA
  V=345*10^3; %Volts
  CompLinha = 231.1*10^3; %Metros
  PotMax = 699*10^6; %MVA


  %% Caracteristicas do cabo CAA (Código T310014)
  RMG=0.0548
  %RMG=0.01021; %em metros a 60 Hz
  ResistCabo=0.1; %Em ohms por quilometro
  %ResistCabo=0.10055; %Em ohms por quilometro
  De=2688; %em metros

  %% Caracteristicas do cabo para-raios OPGW-36B1-90
  RMG2=0.007
  %RMG=0.01021; %em metros a 60 Hz
  ResistCabo2=0.548; %Em ohms por quilometro
  %ResistCabo=0.10055; %Em ohms por quilometro


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%Distancia dos condutores e para-raios (Torre A34 +1800 com pernas de 9 metros)
  %% Distancias solo - fase
  Dea=41.2; %em metros
  Deb=42.25; %em metros
  Dec=41.2; %em metros

  %% Distancias solo - para-raio
  Der1=48.7; %em metros
  Der2=48.7; %em metros

  %% Distancias fase - fase
  Dab=8.631338251; %em metros
  Dbc=8.631338251; %em metros
  Dca=17; %em metros

  %% Distancias para-raio - para-raio
  Dr1r2=12.5; %em metros
  Dr2r1=12.5; %em metros

  %% Distancias fases - para-raios
  Dar1=7.8302; %em metros
  Dbr1=8.9813; %em metros
  Dcr1=16.5472; %em metros
  Dar2=16.5472; %em metros
  Dbr2=8.9813; %em metros
  Dcr2=7.8302; %em metros


  %%Distanias para admitancia
  ya=48;
  yb=48;
  yc=48;
  yr1=54.5;
  yr2=54.5;
  xa=-9.45;
  xb=0;
  xc=9.45;
  xr1=10;
  xr2=-10;

  Hab = sqrt((xa-xb)^2+(ya+yb)^2)
  Hac = sqrt((xa-xc)^2+(ya+yc)^2)
  Hcb = sqrt((xc-xb)^2+(yc+yb)^2)
  Har1 = sqrt((xa-xr1)^2+(ya+yr1)^2)
  Har2 = sqrt((xa-xr2)^2+(ya+yr2)^2)
  Hbr1 = sqrt((xb-xr1)^2+(yb+yr1)^2)
  Hbr2 = sqrt((xb-xr2)^2+(yb+yr2)^2)
  Hcr1 = sqrt((xc-xr1)^2+(yc+yr1)^2)
  Hcr2 = sqrt((xc-xr2)^2+(yc+yr2)^2)
  Hr1r2 = sqrt((xr1-xr2)^2+(yr1+yr2)^2)

  dab = sqrt((xa-xb)^2+(ya-yb)^2)
  dac = sqrt((xa-xc)^2+(ya-yc)^2)
  dcb = sqrt((xc-xb)^2+(yc-yb)^2)
  dar1 = sqrt((xa-xr1)^2+(ya-yr1)^2)
  dar2 = sqrt((xa-xr2)^2+(ya-yr2)^2)
  dbr1 = sqrt((xb-xr1)^2+(yb-yr1)^2)
  dbr2 = sqrt((xb-xr2)^2+(yb-yr2)^2)
  dcr1 = sqrt((xc-xr1)^2+(yc-yr1)^2)
  dcr2 = sqrt((xc-xr2)^2+(yc-yr2)^2)
  dr1r2 = sqrt((xr1-xr2)^2+(yr1-yr2)^2)

%  Hab=sqrt(((0-8.5)^2)+((41.2+42.25)^2));
%  Hac=sqrt(((0-17)^2)+((41.2+41.2)^2));
%  Hcb=sqrt(((17-8.5)^2)+((Deb+Dec)^2));
%  Har1=sqrt(((0-2.25)^2)+((41.2+48.7)^2));
%  Har2=sqrt(((0-14.75)^2)+((41.2+48.7)^2));
%  Hbr1=sqrt(((8.5-2.25)^2)+((42.25+48.7)^2));
%  Hbr2=sqrt(((8.5-14.75)^2)+((42.25+48.7)^2));
%  Hcr1=sqrt(((17-2.25)^2)+((41.2+48.7)^2));
%  Hcr2=sqrt(((17-14.75)^2)+((41.2+48.7)^2));
%  Hr1r2=sqrt(((2.25-14.75)^2)+((48.7+48.7)^2));


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%Calculo das impedancias
  %%Impedancias proprias das fases
  Zaa=(ResistCabo+rd)+i*wk*log(De./RMG);
  Zbb=(ResistCabo+rd)+i*wk*log(De./RMG);
  Zcc=(ResistCabo+rd)+i*wk*log(De./RMG);

  %%Impedancias mutuas entre as fases
  Zab=rd+i*wk*log(De./Dab);
  Zba=Zab;
  Zbc=rd+i*wk*log(De./Dbc);
  Zcb=Zbc;
  Zac=rd+i*wk*log(De./Dca);
  Zca=Zac;

  %%Impedancias proprias para-raios
  Zr1r1=(ResistCabo2+rd)+i*wk*log(De./RMG2);
  Zr2r2=(ResistCabo2+rd)+i*wk*log(De./RMG2);

  %%Impedancias mutuas fases - para-raios
  Zar1=rd+i*wk*log(De./dar1);
  Zr1a=Zar1;
  Zbr1=rd+i*wk*log(De./dbr1);
  Zr1b=Zbr1;
  Zcr1=rd+i*wk*log(De./dcr1);
  Zr1c=Zcr1;

  Zar2=rd+i*wk*log(De./dar2);
  Zr2a=Zar2;
  Zbr2=rd+i*wk*log(De./dbr2);
  Zr2b=Zbr2;
  Zcr2=rd+i*wk*log(De./dcr2);
  Zr2c=Zcr2;

  %%Impedancias mutuas entre os para-raios
  Zr1r2=rd+i*wk*log(De./Dr1r2);
  Zr2r1=rd+i*wk*log(De./Dr2r1);


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%Matriz de impedancias
  Zcarson=[Zaa,Zab,Zac,Zar1,Zar2;Zba,Zbb,Zbc,Zbr1,Zbr2;Zca,Zcb,Zcc,Zcr1,Zcr2;Zr1a,Zr1b,Zr1c,Zr1r1,Zr1r2;Zr2a,Zr2b,Zr2c,Zr2r1,Zr2r2];

  %%Reducao da matriz
  P1=[Zaa,Zab,Zac;Zba,Zbb,Zbc;Zca,Zcb,Zcc];
  P2=[Zar1,Zar2;Zbr1,Zbr2;Zcr1,Zcr2];
  P3=[Zr1a,Zr1b,Zr1c;Zr2a,Zr2b,Zr2c];
  P4=[Zr1r1,Zr1r2;Zr2r1,Zr2r2];
  P4inv=inv(P4);
  P2P4=P2*P4inv;
  P2P4P3=P2P4*P3;
  P=P1-P2P4P3;
  Zabc=inv(P);

  Zp = (Zabc(1,1)+Zabc(2,2)+Zabc(3,3))/3; %impedancia propria.
  Zm =(Zabc(1,2)+Zabc(1,3)+Zabc(2,3))/3; %impedancia mutua.

  %Encontrando matriz impedancia de sequancias 012
  Ztransp = [Zp,Zm,Zm;Zm,Zp,Zm;Zm,Zm,Zp];
  Z012=(Ainv*Ztransp*A)

  Z0=Z012(1,1)
  Z1=Z012(2,2)

  Zkm=Z0 %em ohms por quilometro

  %%Falta calcular os parametros em paralelo C e Y
  %%Matriz de admitancia
  MUL=17.975103*10^6;

  %Coeficientes de campo proprio
  Aaa=MUL*log(48./0.0548)
  Abb=MUL*log(48./0.0548)
  Acc=MUL*log(48./0.0548)
  Ar1r1=MUL*log(54.5./0.007)
  Ar2r2=MUL*log(54.5./0.007)
  %Aaa=MUL*log(41.2./RMG);
  %Abb=MUL*log(42.25./RMG);
  %Acc=MUL*log(41.2./RMG);
  %Ar1r1=MUL*log(48.7./RMG);
  %Ar2r2=MUL*log(48.7./RMG);

%  %Coeficientes de campo mutuo
  Aab = 17.975103e06*log(Hab./dab)
  Aac = 17.975103e06*log(Hac./dac)
  Acb = 17.975103e06*log(Hcb./dcb)
  Aar1 = 17.975103e06*log(Har1./dar1)
  Aar2 = 17.975103e06*log(Har2./dar2)
  Abr1 = 17.975103e06*log(Hbr1./dbr1)
  Abr2 = 17.975103e06*log(Hbr2./dbr2)
  Acr1 = 17.975103e06*log(Hcr1./dcr1)
  Acr2 = 17.975103e06*log(Hcr2./dcr2)
  Ar1r2 = 17.975103e06*log(Hr1r2./dr1r2)

%  Aab=MUL*log(Hab./Dab);
%  Aac=MUL*log(Hac./Dca);
% Acb=MUL*log(Hcb./Dbc);
%  Aar1=MUL*log(Har1./Dar1);
%  Aar2=MUL*log(Har2./Dar2);
%  Abr1=MUL*log(Hbr1./Dbr1);
%  Abr2=MUL*log(Hbr2./Dbr2);
%  Acr1=MUL*log(Hcr1./Dcr1);
%  Acr2=MUL*log(Hcr2./Dcr2);
%  Ar1r2=MUL*log(Hr1r2./Dr1r2);

  MatrixA=[Aaa,Aab,Aac,Aar1,Aar2;Aab,Abb,Acb,Abr1,Abr2;Aac,Acb,Acc,Acr1,Acr2;Aar1,Abr1,Acr1,Ar1r1,Ar1r2;Aar2,Abr2,Acr2,Ar1r2,Ar2r2];

  %%Reducao da matriz
  P1A=[Aaa,Aab,Aac;Aab,Abb,Acb;Aac,Acb,Acc];
  P2A=[Aar1,Aar2;Abr1,Abr2;Acr1,Acr2];
  P3A=[Aar1,Abr1,Acr1;Aar2,Abr2,Acr2];
  P4A=[Ar1r1,Ar1r2;Ar1r2,Ar2r2];
  P4invA=inv(P4A);
  P2P4A=P2A*P4invA;
  P2P4P3A=P2P4A*P3A;
  PA=P1A-P2P4P3A;
  C=inv(PA);

  Yp = (C(1,1)+C(2,2)+C(3,3))/3; %impedancia propria.
  Ym =(C(1,2)+C(1,3)+C(2,3))/3; %impedancia mutua.

  %Encontrando matriz impedancia de sequancias 012
  Ytransp = [Yp,Ym,Ym;Ym,Yp,Ym;Ym,Ym,Yp];

  Y012=((2*pi*60)*i*Ainv*Ytransp*A)

  Y0=Y012(1,1)
  Y1=Y012(2,2)

  Ykm=Y0 %em ohms por quilometro

  %Impedancia caracteristica





