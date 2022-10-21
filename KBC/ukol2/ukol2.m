close all
clear variables

h = 6.62607015;

S = [-2 1 0
     1 -2 1
     0 1 -2]/h^2;

T = [1 0 0
     0 1 0
     0 0 1];
[E,k] = eig(S,T)

sqrt(abs(k))
plot(E)


