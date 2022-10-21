function kn = LinearTM( Nx, Ny);

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

iNx = Nx + 1; iNy = Ny + 1;

S = S(Nx+2:iNx*Ny,Nx+2:iNx*Ny);
T = T(Nx+2:iNx*Ny,Nx+2:iNx*Ny);
ind = 2;
for n=2:Ny
  lw  = (n-2)*(Nx-1);
  hg  = (n-1)*(Nx-1);
  Sr(lw+1:hg,1:(Ny-1)*iNx) = S(lw+ind:hg+ind-1,:);
  Tr(lw+1:hg,1:(Ny-1)*iNx) = T(lw+ind:hg+ind-1,:);
  ind = ind + 2;
end
ind = 2;
for n=2:Ny
  lw  = (n-2)*(Nx-1);
  hg  = (n-1)*(Nx-1);
  St(1:(Nx-1)*(Ny-1),lw+1:hg) = Sr(:,lw+ind:hg+ind-1);
  Tt(1:(Nx-1)*(Ny-1),lw+1:hg) = Tr(:,lw+ind:hg+ind-1);
  ind = ind + 2;
end

clear S T Sr Tr
[E,K] = eig( full(St), full(Tt));
kn  = sqrt( diag( K));

ka( 1) = 338.4;   % TM11
ka( 2) = 413.7;   % TM21
ka( 3) = 515.4;   % TM31

Em = zeros( iNy, iNx);

for m=1:3
  [val,ind] = min( kn);
  for n=2:Ny
    Em(n,2:Nx) = E(1+(n-2)*(Nx-1):(n-1)*(Nx-1),ind)';
  end
  figure; surf( Em/max(max(abs(Em))));
  title(['ka = ',num2str( ka(m)),'  kn = ',num2str( val)]);
  
  for n=2:Nx
    for m=2:Ny
      Hy(m,n) = 0.5*(Em(m,n+1)-Em(m,n-1))/dx(n);
      Hx(m,n) = 0.5*(Em(m+1,n)-Em(m-1,n))/dy(m);
    end
  end
  Hmax = max( max( sqrt( abs( Hx*Hy'))));
  figure;  quiver( Hx/Hmax, Hy/Hmax);
  title(['Ht, kn = ',num2str( val)]);
  figure;  quiver( Hy/Hmax, Hx/Hmax);
  title(['Et, kn = ',num2str( val)]);
  
  kn( ind) = 1e+5;
end