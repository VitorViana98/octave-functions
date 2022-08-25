function [Zabc, Zaa]=linha_transmissao()
clear all;
clc;

a=0.5+i*0.866;

A=[1,1,1;1,a^2,a;1,a,a^2];

Ds=0.01021;
De=2.688;
wk=0.12134;

rd=0.0015;

ra=0.10055;
rb=0.10055;
rc=0.10055;

Dea=41.2;
Deb=41.2;
Dec=41.2;

Dab=8.564;
Dbc=Dab;
Dac=17;

Der1=48.7;
Der2=48.7;
Dr1r2=12.5;

Dar1=7.8302;
Dbr1=8.9813;
Dcr1=16.5472;

Dar2=16.5472;
Dbr2=8.9813;
Dcr2=7.8302;

  %Impedancia propria fases
Zaa=(ra+rd)+i*wk*log(De./Ds)
Zbb=Zaa;
Zcc=Zaa;

  %Impedancia mutua entre fases
Zab=rd+i*wk*log(De./Dab);
Zba=Zab;
Zbc=Zab;
Zcb=Zbc;
Zac=rd+i*wk*log(De./Dac);
Zca=Zac;

  %Impedancia propria para raio
Zr1r1=Zaa;
Zr2r2=Zaa;

  %Impedancia mutua para raio e fases
Zar1=rd+i*wk*log(De./Dar1);
Zr1a=Zar1;
Zbr1=rd+i*wk*log(De./Dbr1);
Zr1b=Zbr1;
Zcr1=rd+i*wk*log(De./Dcr1);
Zr1c=Zcr1;

Zar2=rd+i*wk*log(De./Dar2);
Zr2a=Zar2;
Zbr2=rd+i*wk*log(De./Dbr2);
Zr2b=Zbr2;
Zcr2=rd+i*wk*log(De./Dcr2);
Zr2c=Zcr2;

 %Impedancia mutua para raios
Zr1r2=rd+i*wk*log(De./Dr1r2);
Zr2r1=Zr1r2;

  %Metodo de Carson

 Zcarson=[Zaa,Zab,Zac,Zar1,Zar2;Zba,Zbb,Zbc,Zbr1,Zbr2;Zca,Zcb,Zcc,Zcr1,Zcr2;Zr1a,Zr1b,Zr1c,Zr1r1,Zr1r2;Zr2a,Zr2b,Zr2c,Zr2r1,Zr2r2];

  %Reduzindo a matriz
 P1=[Zaa,Zab,Zac;Zba,Zbb,Zbc;Zca,Zcb,Zcc];
 P2=[Zar1,Zar2;Zbr1,Zbr2;Zcr1,Zcr2];
 P3=[Zr1a,Zr1b,Zr1c;Zr2a,Zr2b,Zr2c];
 P4=[Zr1r1,Zr1r2;Zr2r1,Zr2r2];

 P4inv=inv(P4);
 P2P4=P2*P4inv;
 P2P4P3=P2P4*P3;
 P=P1-P2P4P3;

  %A partir de P é possivel achar Zabc
 Zabc=inv(P);
P

 end
