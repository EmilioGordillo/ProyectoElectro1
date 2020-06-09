clc; clf; clear;
%Proyecto Teoria Electromagnetica
%Santiago Galicia - 18483
%Voltaje en una Esfera con Densidad de Carga Varible

R = 2; ep = (8.854187817)*(10.^(-12)); % constants that are still a mystery. 

V0 = @(r,theta) (3.*r.*cos(theta)./(10*ep))-((12.*(r.^3)./(35*ep*(R.^2))).*((5.*((cos(theta)).^3)./2)-((3.*cos(theta))./2)));
V1 = @(r,theta) (3.*(R.^3).*cos(theta)./(10*ep.*(r.^2)))-((12*(R.^5)./(35*ep*(r.^4))).*((5.*((cos(theta)).^3)./2)-((3.*cos(theta))./2)));

npts = 50;
r0 = linspace(0,R,npts)';
r1 = linspace(R,10,npts)';
phi = linspace(0,2*pi, npts)';

[R0, ~] = meshgrid(r0,phi); 
[R1, Phi] = meshgrid(r1,phi); 

P0 = V0(R0,Phi);  
P1 = V1(R1,Phi);  

[X0,Y0] = pol2cart(Phi,R0);
[X1,Y1] = pol2cart(Phi,R1);

[EX0, EY0] = gradient(P0);
EX0 = -EX0;
EY0 = -EY0./R0;
EZ0 = ones(size(EX0));

[EX1, EY1] = gradient(P1);
EX1 = -EX1;
EY1 = -EY1./R1;

nexttile
surfc(X0,Y0,P0)
hold on
surfc(X1,Y1,P1)
hold off

xlabel('X')
ylabel('Y')
zlabel('Potencial Electrico')
title('Potencial Electrico')
colorbar

nexttile
quiver(X0,Y0,EX0,EY0)
hold on
quiver(X1,Y1,EX1,EY1)
hold off
xlabel('X')
ylabel('Y')
title('Campo Electrico')
set(gca,'Color','k')


nexttile
contourf(X0,Y0,P0)
hold on
contourf(X1,Y1,P1)
hold off
xlabel('X')
ylabel('Y')
title('Potencial Electrico')

colorbar
