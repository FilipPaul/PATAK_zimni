clear variables
%% Discretization (cut front-view into n triangles..)
% 2 - plates
%   
%  | -> conductive

%  |                    | h
%  |                    | e
%  |       AIR          | i
%  |                    | g
%  |                    | h
%  |                    | t
%   <-------width ------>

%PROBLEM TO SOLVE: SE + k^2TE = 0
%% TO BE SET:...................
mode = "rect_TE";%rectangular or parallel waveguide.. also can be: "parallel_TE","rect_TM" ,"rect_TE"
width = 22.86e-3; %in case of parallel plates -> this variable acts like d
height = 10.16e-3;% -> in case of parallel plates ignore this value.  
N_elements_x = 15; %N of rectangular elements -> will be converted to double amount of triangular elemnts
N_elements_y = 10;
mode_to_plot = 3; 



if( mode == "parallel_TE" || mode == "parallel_TM")
   height = width/1e3; 
end
dx = width / N_elements_x;
dy = height / N_elements_y;
N_of_triangles = 2 * N_elements_y * N_elements_x; %N of triangular elements

%% Aproximation and residual problem (S and T)

% using look-up tables

Q1 = [0 0 0
      0 1 -1
      0 -1 1]/2;
% not needed -> cot(pi/2) = 0
Q2 = [1 0 -1  
      0 0 0
      -1 0 1]/2;

Q3 = [1 -1 0
      -1 1 0
      0 0 0]/2;

%all elements are same -> area A is equal (dx*dy/2)
A = dx*dy/2;
Te = [2 1 1
      1 2 1
      1 1 2]*(A/12);

%% Diagonal Matrix for isolated finite elements
S_diag = zeros(N_of_triangles*3,N_of_triangles*3);%memory alocation
T_diag = zeros(N_of_triangles*3,N_of_triangles*3);%memory alocation

%Also 3x3 matrices are IDENTICAL.....
angles = [acot(dx/dy), pi/2, atan(dx/dy)]; %%Angles of triangle in radians
S_3_x_3 = Q1.*cot(angles(1)) + Q3.*cot(angles(3)) + Q2.*cot(angles(2));


for i = 1:1:N_of_triangles
    S_diag(3*(i-1)+1:3*(i-1)+3,3*(i-1)+1:3*(i-1)+3) = S_3_x_3; 
    T_diag(3*(i-1)+1:3*(i-1)+3,3*(i-1)+1:3*(i-1)+3) = Te;
end
%S_diag(1:15,1:15)
%T_diag(1:15,1:15)

%% C Matrix
C = get_c1(N_elements_x,N_elements_y,N_of_triangles);

%% Mesh combining and boundary conditions..
S = C'*S_diag*C;
T = C'*T_diag*C;

field = "H";
global_nodes_to_remove = [];
if (mode == "parallel_TM" || mode == "rect_TM")
    field = "E";
    global_nodes_to_remove = [1];

    %rows 1,21,22,42.43,63,64 - 0+1+Nx+1+Nx+1 ..... 
    i = 1;
    while (i < N_elements_y*2)
        if mod(i,2) == 0
            global_nodes_to_remove = [global_nodes_to_remove,global_nodes_to_remove(end)+1];
        else
            global_nodes_to_remove = [global_nodes_to_remove,global_nodes_to_remove(end)+N_elements_x];
        end
        i = i+1;
    end
end

if (mode == "rect_TM")
%columns
    for i = 1:N_elements_x+1
        global_nodes_to_remove = [global_nodes_to_remove i];
        global_nodes_to_remove = [global_nodes_to_remove , N_elements_y*(N_elements_x+1)+i];

    end
end


if (mode == "parallel_TM" || mode == "rect_TM")
    global_nodes_to_remove = unique(global_nodes_to_remove);
    remove_correction = 0;
    for i = 1:length(global_nodes_to_remove)
        S(global_nodes_to_remove(i)-remove_correction,:) = [];
        S(:,global_nodes_to_remove(i)-remove_correction) = [];
        T(global_nodes_to_remove(i)-remove_correction,:) = [];
        T(:,global_nodes_to_remove(i)-remove_correction) = [];
        remove_correction = remove_correction +1;
    end
end


%% Solution eigen val/vect problem
[E,K] = eig(S,T);
k =real(sqrt(diag(K))); %print K-values



%% x,y cordinates of nodes
x_values = 0:dx:dx*(N_elements_x);
y_values = 0:dy:dy*(N_elements_y);

figure
i = 0;
corection = 0;%to correct visualisation -> recover indexes after boundary condition deletion...
mode_correction = 0; %to ignore zero modes
if round(k(1)) ~= 0
    mode_correction = 1;
end
for y= 1:1:N_elements_y+1
    for x = 1:1:N_elements_x+1
        i = i+1;
       if any(global_nodes_to_remove(:) == i)
        plot3(x_values(x),y_values(y),0, "xr")
        corection = corection + 1;
        hold on
       else
        
        plot3(x_values(x),y_values(y),E(i-corection,mode_to_plot+1-mode_correction), "xr")
        hold on
       end
    end
end
grid on
grid minor
title(mode + mode_to_plot + " " + field + "-Field,k = " + k(mode_to_plot+1-mode_correction), 'Interpreter', 'none')
xlabel("x")
ylabel("y")
zlabel(field+"(x,y)")

disp(k(1:4))%display first 4 modes k values


