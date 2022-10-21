function C = get_c1( Nx, Ny, N);
iNx = Nx + 1;
iNy = Ny + 1;

C = sparse( 3*N, iNx*iNy);    % matice C a její sestavení

C(1,1)=1; C(iNx*3,1)=1;       % první uzel první øady
for nx=2:Nx                   % druhý až pøedposl.uzel první ø.
  C(3*nx-4,nx)   =1;            % levý prvek
  C(3*nx-2,nx)   =1;            % pravý prvek
  C(3*(Nx+nx),nx)=1;            % horní prvek
end
C(3*Nx-1,iNx)=1;              % poslední uzel první øady

for ny=2:Ny                   % druhá až pøedposl. øada
  ind = (ny-1)*iNx+1;         % první uzel
  C(3*(2*ny-3)*Nx + 2,ind)=1;   % dolní prvek
  C(3*(2*ny-2)*Nx + 1,ind)=1;   % prostøední prvek
  C(3*(2*ny-1)*Nx + 3,ind)=1;   % horní prvek
  for nx=2:Nx                 % druhý až pøedposl.uzel
    ind = ind + 1;
    C(3*(2*ny-4)*Nx + 3*(nx-1) + 0, ind)=1;  % nejnižší k.p.
    C(3*(2*ny-3)*Nx + 3*(nx-2) + 1, ind)=1;  % nižší levý k.p.
    C(3*(2*ny-3)*Nx + 3*(nx-1) + 2, ind)=1;  % nižší pravý k.p.
    C(3*(2*ny-2)*Nx + 3*(nx-2) + 2, ind)=1;  % vyšší levý k.p.
    C(3*(2*ny-2)*Nx + 3*(nx-1) + 1, ind)=1;  % vyšší pravý k.p.
    C(3*(2*ny-1)*Nx + 3*(nx-0) + 0, ind)=1;  % nejvyšší k.p.
  end
  ind = ind + 1;              % poslední uzel
  C(3*(2*ny-3)*Nx - 0,ind)=1;   % dolní prvek
  C(3*(2*ny-2)*Nx - 2,ind)=1;   % prostøední prvek
  C(3*(2*ny-1)*Nx - 1,ind)=1;   % horní prvek
end

C(3*(2*Ny-1)*Nx+2,iNx*Ny+1)=1;  % první uzel poslední øady
for nx=2:Nx                     % druhý až pøedposl.uzel poslední ø.
  ind = iNx*Ny+nx;
  C(3*(2*Ny-1)*Nx + 3*(nx-2) + 1,ind)=1;     % levý prvek
  C(3*(2*Ny-1)*Nx + 3*(nx-1) + 2,ind)=1;     % pravý prvek
  C(3*(2*Ny-2)*Nx + 3*(nx-1) + 0,ind)=1;     % horní prvek
end
C(3*(2*Ny-1)*Nx-0,iNx*iNy)=1;   % poslední uzel první øady
C(3*(2*Ny-0)*Nx-2,iNx*iNy)=1;