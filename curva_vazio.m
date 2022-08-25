function []=curva_vazio()
  close all
  clear all
  clc

  If=[0.47,0.45,0.40,0.35,0.3,0.25,0.2,0.15,0.1,0.05,0.02,0]
  V=[375,375,375,375,375,375,375,375,375,375,375,375]
  V2=1.2*[375,375,375,375,375,375,375,375,375,375,375,375]
  Vl=[494,487,472,452,424,388,335,270,190,104,59,29]
  Vl2=[490,480,460,438,408,368,310,245,166,78,40,0]

  plot(If,Vl,"Color","c","Linewidth",2.0)
  hold on;
  plot(If,Vl2,"Color","k","Linewidth",2.0)
  hold on;
  plot(If,V,"Color","r","Linewidth",2.0,"linestyle","--")
  legend ("Valor Corrigido","Valor Medido","Tensão Nominal","fontsize", 14)
  plot(If,V2,"Color","m","Linewidth",2.0,"linestyle","--")
  legend ("Valor Medido","Valor Corrigido","Tensão Nominal","1.2Vpu","fontsize", 14)


  xlabel("Corrente de campo (A)","Fontweight","Bold","fontsize", 14);
  ylabel("Tensão de Linha (Vl)","Fontweight","Bold","fontsize", 14);
  title ("Curva de Magnetização - Ensaio Gerador a Vazio","Fontweight","Bold","fontsize", 16);
  axis([0 0.47 0 670]);
  grid on;
