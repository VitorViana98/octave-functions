function [GM GMd wg PM wp]=my_bode_o(sys) % [Gain Margin, ?, ?, Phase Margin, ?]
  [mag,ph,w]=bode(sys)

  a2=abs(1-mag);
  a3=find(a2==min(a2)) %valor de índice do ponto onde o ganho é 0

  b1=[mag(a3-1) mag(a3) mag(a3+1)]';
  b2=[ph(a3-1) ph(a3) ph(a3+1)]';
  b3=[w(a3-1) w(a3) w(a3+1)]';
  PM = 180 + interp1(b1,b2,1)
  wg=interp1(b1,b3,1);


  c1=abs(180-abs(ph)); %vamos encontrar o ponto onde a fase é -180 graus
  c2=find(c1==min(c1));

  %desenhando o gráfico de bode com as margens de fase e ganho
  figure(1);bode(sys);grid
  margin(sys)

  d1=[mag(c2-1) mag(c2) mag(c2+1)]';
  d2=[ph(c2-1) ph(c2) ph(c2+1)]';
  d3=[w(c2-1) w(c2) w(c2+1)]';
  GM=1/(interp1(d2,d1,-180));
  wp=interp1(d2,d3,-180);
  GMd=20*log(GM);

    %sys=tf(2500,conv([1 5 0],[1 50]))
  %figure(1);bode(sys);grid
  %margin(sys)
