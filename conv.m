function []=conv()
  close all
  clear all
  clc
% M-file: v_curve.m
% M-file para criar um gráfico da corrente de armadura versus a
% corrente de campo para o motor síncrono do Exemplo 5-2
% Primeiro, inicialize os valores da corrente de campo (21 valores
% no intervalo 3,8 a 5,8 A)
i_f = (38:1:58) / 10;
% Agora, inicialize todos os demais valores
i_a = zeros(1,21); % Prepare a matriz i_a
x_s = 2.5; % Reatância síncrona
v_phase = 208; % Tensão de fase em 0 graus
deltal = -17.5 * pi/180; % delta 1 em radianos
e_al = 182 * (cos(deltal) + j * sin(deltal));
% Calcule a corrente de armadura para cada valor
for ii = 1:21
% Calcule o valor de e_a2
e_a2 = 45.5 * i_f(ii);
% Calcule delta2
delta2 = asin (abs(e_al) / abs(e_a2) * sin(deltal));
% Calcule o fasor e_a2
e_a2 = e_a2 * (cos(delta2) + j * sin(delta2));
% Calcule i_a
i_a(ii) = (v_phase - e_a2) / (j * x_s);
end
% Plote a curva V
plot(i_f,abs(i_a),"Color","k","Linewidth",2.0);
xlabel("Corrente de campo (A)","Fontweight","Bold");
ylabel("Corrente de armadura (A)","Fontweight","Bold");
title ("Curva V de Motor Síncrono","Fontweight","Bold");
grid on;

