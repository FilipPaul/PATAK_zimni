function C = get_c1( Nx, Ny, N);
iNx = Nx + 1;
iNy = Ny + 1;

C = sparse( 3*N, iNx*iNy);    % matice C a jej� sestaven�

C(1,1)=1; C(iNx*3,1)=1;       % prvn� uzel prvn� �ady
for nx=2:Nx                   % druh� a� p�edposl.uzel prvn� �.
  C(3*nx-4,nx)   =1;            % lev� prvek
  C(3*nx-2,nx)   =1;            % prav� prvek
  C(3*(Nx+nx),nx)=1;            % horn� prvek
end
C(3*Nx-1,iNx)=1;              % posledn� uzel prvn� �ady

for ny=2:Ny                   % druh� a� p�edposl. �ada
  ind = (ny-1)*iNx+1;         % prvn� uzel
  C(3*(2*ny-3)*Nx + 2,ind)=1;   % doln� prvek
  C(3*(2*ny-2)*Nx + 1,ind)=1;   % prost�edn� prvek
  C(3*(2*ny-1)*Nx + 3,ind)=1;   % horn� prvek
  for nx=2:Nx                 % druh� a� p�edposl.uzel
    ind = ind + 1;
    C(3*(2*ny-4)*Nx + 3*(nx-1) + 0, ind)=1;  % nejni��� k.p.
    C(3*(2*ny-3)*Nx + 3*(nx-2) + 1, ind)=1;  % ni��� lev� k.p.
    C(3*(2*ny-3)*Nx + 3*(nx-1) + 2, ind)=1;  % ni��� prav� k.p.
    C(3*(2*ny-2)*Nx + 3*(nx-2) + 2, ind)=1;  % vy��� lev� k.p.
    C(3*(2*ny-2)*Nx + 3*(nx-1) + 1, ind)=1;  % vy��� prav� k.p.
    C(3*(2*ny-1)*Nx + 3*(nx-0) + 0, ind)=1;  % nejvy��� k.p.
  end
  ind = ind + 1;              % posledn� uzel
  C(3*(2*ny-3)*Nx - 0,ind)=1;   % doln� prvek
  C(3*(2*ny-2)*Nx - 2,ind)=1;   % prost�edn� prvek
  C(3*(2*ny-1)*Nx - 1,ind)=1;   % horn� prvek
end

C(3*(2*Ny-1)*Nx+2,iNx*Ny+1)=1;  % prvn� uzel posledn� �ady
for nx=2:Nx                     % druh� a� p�edposl.uzel posledn� �.
  ind = iNx*Ny+nx;
  C(3*(2*Ny-1)*Nx + 3*(nx-2) + 1,ind)=1;     % lev� prvek
  C(3*(2*Ny-1)*Nx + 3*(nx-1) + 2,ind)=1;     % prav� prvek
  C(3*(2*Ny-2)*Nx + 3*(nx-1) + 0,ind)=1;     % horn� prvek
end
C(3*(2*Ny-1)*Nx-0,iNx*iNy)=1;   % posledn� uzel prvn� �ady
C(3*(2*Ny-0)*Nx-2,iNx*iNy)=1;