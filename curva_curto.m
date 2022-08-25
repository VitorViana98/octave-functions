function []=curva_curto()
  close all
  clear all
  clc

  If=[0.5,0.47,0.45,0.40,0.35,0.3,0.25,0.2,0.15,0.1,0.05,0.02,0];
  Ia=[3.94,3.77,3.6,3.24,2.83,2.44,2.06,1.65,1.24,0.86,0.46,0.23,0.04];
  In=[3,3,3,3,3,3,3,3,3,3,3,3,3];

  plot(If,Ia,"Color","b","Linewidth",2.0)
  hold on
  plot(If,In,"Color","r","Linewidth",2.0)
  legend ("Corrente Medida","Corrente Nominal","fontsize", 14)


  xlabel("If (A)","Fontweight","Bold","fontsize", 14);
  ylabel("Ia (A)","Fontweight","Bold","fontsize", 14);
  title ("Ensaio Curto-Circuito Gerador","Fontweight","Bold","fontsize", 16);
  axis([0 0.47 0 4.5]);
  grid on;
