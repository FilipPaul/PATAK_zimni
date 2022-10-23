% function parallel_tm(N, d)
% N   number of finite elements
% d   plate - plate distance
close all
clear variables
N = 1200;
d = 12.45e-3;

deltaX = d/N;
Se = 1/deltaX*[1 -1; -1 1];  % single element matrices
Te = deltaX*[2 1; 1 2]*1/6;

S = zeros(2*N, 2*N);  % large matrices
T = zeros(2*N, 2*N);
C = zeros(2*N, N+1);

% put element matrices on diagonal of large matrices, 
% coupling matrix C assembly
for iN = 1:N
   ind = (iN-1)*2+1:iN*2;
   S(ind, ind) = Se;
   T(ind, ind) = Te;
   
   C((iN-1)*2+1, iN) = 1;
   C(2*iN, iN+1) = 1;
end
C(end, end) = 1;

Sc = C'*S*C;  % coupling of elements and global nodes
Tc = C'*T*C;


%Boundary condition at conductive plates
Sc(1,:) = [];
Sc(:,1) = [];
Tc(1,:) = [];
Tc(:,1) = [];
Sc(end,:) = [];
Sc(:,end) = [];
Tc(end,:) = [];
Tc(:,end) = [];


[E,K] = eig(Sc, Tc);           % eigenvalue problem
k = imag(sqrt(diag(-K)));      % cut-off wavenumbers 
%[val, ind] = min( k);           % zero mode elimination not needed
%k( ind) = 1e9; 

for n=1:3
  figure
  [val,ind] = min( k);
  plot( d*(1:N-1)'/(N-2), E(:,ind), "-r");
  hold on
  plot(0,0,"xb") %boundary points -> to bee able see error
  plot(d,0,"xb")
  grid on
  grid minor
  title(['kn = ', num2str( val), ', ka = ', num2str( n*pi/d)]);
  k( ind) = 1e9;%big number to put it on end..
end