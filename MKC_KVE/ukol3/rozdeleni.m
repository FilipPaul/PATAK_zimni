clear all
close all
clc
%% parametry
e_konst = 1.6e-19;
k = 1.380649e-23; %J/K
% k = 8.617333262e-5; %eV/K
U = 1*e_konst;
E = (0:0.0011:2)*e_konst;
T = [0,500,2000];
lines = ["-r","-g", "-b"];
figure(1)

%% Fermi - Dirac
subplot(2,2,1)
hold on
for i = 1:length(T)
   f = 1./(exp( ( E-U)/( k*T(i) ) ) + 1)   ;
   plot(E/e_konst,f,lines(i))
   
end
grid on
grid minor
title( "Fermi-Dirrack: U = " + U + "J")
xlabel("E [eV]")
ylabel("propability f [-]")
legend("T = "+ string(T)+ "K" )

%% Bosse-Einstein
subplot(2,2,2)
hold on
E = (U/e_konst:0.001:1.2)*e_konst;
for i = 1:length(T)
   N = 1./(exp( ( E-U)/( k*T(i) ) ) - 1)   ;
   plot(E/e_konst,N, lines(i))
   
end
grid on
grid minor
title( "Bosse - Einstein: U = " + U + "J")
xlabel("E [eV]")
ylabel("<N>")
legend("T = "+ string(T)+ "K" )

%% Maxwell- Boltzman

subplot(2,2,3)
hold on
E = (1.6:0.0011:2)*e_konst;
for i = 1:length(T)
   N = exp((U-E)./(k*T(i)))   ;
   plot(E/e_konst,N, lines(i))
   
end
grid on
grid minor
title( "Maxwell-Boltzman: U = " + U + "J")
xlabel("E [eV]")
ylabel("<N>")
legend("T = "+ string(T)+ "K" )


%% Planckovo rozdělení
h = 6.62607015e-34;
h_plank = h/(2*pi);
lambda = (0.1:0.001:20) * 1e-6;
w = 2*pi*3e8./lambda;
subplot(2,2,4)
hold on
for i = 1:length(T)
   N = 1./( exp( (h_plank*w)/(k*T(i)) ) -1 ) ;
%    N = h_plank/(pi^2*(3e8)^2).*w.^3./(exp( (h_plank.*w)./(k*T(i)) ) -1);
%    N = h_plank/(pi^2*(3e8)^2).*w.^3.*N;
   plot(lambda.*1e6,N, lines(i))
   
end
grid on
grid minor
title( "Planckovo rozdělení")
xlabel("\lambda [um]")
ylabel("<NF>")
legend("T = "+ string(T)+ "K" )

%% Gausovo rozdělení
h = 6.62607015e-34;
h_plank = h/(2*pi);
lambda = (0.1:0.001:20) * 1e-6;
w = 2*pi*3e8./lambda;
subplot(2,2,4)
hold on
for i = 1:length(T)
   N = 1./( exp( (h_plank*w)/(k*T(i)) ) -1 ) ;
%    N = h_plank/(pi^2*(3e8)^2).*w.^3./(exp( (h_plank.*w)./(k*T(i)) ) -1);
%    N = h_plank/(pi^2*(3e8)^2).*w.^3.*N;
   plot(lambda.*1e6,N, lines(i))
   
end
grid on
grid minor
title( "Gausovo rozdělení")
xlabel("\lambda [um]")
ylabel("<NF>")
legend("T = "+ string(T)+ "K" )