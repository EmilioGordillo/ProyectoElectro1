clc; clf; clear;
%Proyecto Teoria Electromagnetica
%Emilio Gordillo - 18062
%Voltaje en un cilindro centrado en Z

%Establezco los intervalos para la funcion


%Asigno un valor para el radio del cilindro y el campo en el que se sumerge
RA = 20;
E = 10;
ep = (8.854187817)*(10.^(-12));

%Realizo la operacion
V = @(r,theta) ((E*(RA.^2))-(E.*(r.^2))).*cos(theta);

npts = 50;
r = linspace(0,30,npts)';
phi = linspace(0,2*pi, npts)';

[R, Phi] = meshgrid(r,phi); 

[X,Y] = pol2cart(Phi,R);

P = V(R,Phi);  

nexttile
surfc(X,Y,P)
xlabel('X')
ylabel('Y')
zlabel('Potencial Eléctrico')
title('Potencial Eléctrico')
colorbar

nexttile
contourf(X,Y,P)
xlabel('X')
ylabel('Y')
title('Potencial Eléctrico')
hold on

colorbar
