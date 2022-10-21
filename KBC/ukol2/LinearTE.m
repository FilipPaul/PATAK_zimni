function kn = LinearTE( Nx, Ny);

a  = 22.86e-3;
b  = 10.16e-3;

dx = ones(1,Nx) * (a/Nx);
dy = ones(1,Ny) * (b/Ny);

Q1 = [  0  0  0;  0  1 -1;  0 -1  1] / 2;
Q3 = [  1 -1  0; -1  1  0;  0  0  0] / 2;
Te = [  2  1  1;  1  2  1;  1  1  2] /12;

N  = 2 * Nx * Ny;
St = sparse( 3*N, 3*N);
Tt = sparse( 3*N, 3*N);

n = 0;
for ny=1:Ny
  for nx=1:Nx
    n  = n + 1;
    lw = 3*n-2;
    hg = 3*n;
    St(lw:hg,lw:hg) = Q1 * dx(nx)/dy(ny) + Q3 * dy(ny)/dx(nx);
    Tt(lw:hg,lw:hg) = Te * dx(nx)*dy(ny)/2;
    St(lw+3*Nx:hg+3*Nx,lw+3*Nx:hg+3*Nx) = St(lw:hg,lw:hg);
    Tt(lw+3*Nx:hg+3*Nx,lw+3*Nx:hg+3*Nx) = Tt(lw:hg,lw:hg);
  end
  n = n + Nx;
end

C = get_c1( Nx, Ny, N)

S = C'*St*C; 
T = C'*Tt*C;

clear C St Tt

[H,K] = eig( full(S), full(T));
kn  = sqrt( diag( K));

ka( 1) = 137.4;   % TE10
ka( 2) = 274.9;   % TE20
ka( 3) = 309.2;   % TE01

[kmin,imin] = min( kn);
kn( imin) = 1e5;

for m=1:3
  [val,ind] = min( kn);
  for n=1:(Ny+1)
    Hm(n,:) = H(1+(n-1)*(Nx+1):n*(Nx+1),ind)';
  end
  figure;  surf( Hm/max(max(abs(Hm))));
  title(['ka = ',num2str( ka(m)),'  kn = ',num2str( val)]);
  
  for n=2:Nx
    for m=2:Ny
      Ey(m,n) = 0.5*(Hm(m,n+1)-Hm(m,n-1))/dx(n);
      Ex(m,n) = 0.5*(Hm(m+1,n)-Hm(m-1,n))/dy(m);
    end
  end
  Emax = max( max( sqrt( abs( Ex*Ey'))));
  figure;  quiver( Ex/Emax, Ey/Emax);
  title(['Et, kn = ',num2str( val)]);
  figure;  quiver( Ey/Emax, Ex/Emax);
  title(['Ht, kn = ',num2str( val)]);

  kn( ind) = 1e+5;
end