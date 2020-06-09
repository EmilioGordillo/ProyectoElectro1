clc; clf; clear;
%Proyecto Teoria Electromagnetica
%Santiago Galicia - 18483
%Voltaje de Dos Esferas Concentricas

k=5; a=3; b =6; ep = (8.854187817)*(10.^(-12)); % constants that are still a mystery. 

V0 = @(r,theta) r-r;
V1 = @(r,theta) (k*b*a./(3*ep.*r))-(k*b./(3*ep))+((((2*k.*r.^2)./(15*ep*b))-((2*k*a.^5)./(15*b*ep.*r.^3))).*((3.*(cos(theta).^2))-1)); % Need thresholding here. 
V2 = @(r,theta) ((k*b*(a-b))./(ep*3.*r))+((2*k*((b.^5)-(a.^5))).*(((3.*(cos(theta).^2))-1))./(15*b*ep.*(r.^3)));
sig = @(r,theta) k.*cos(2.*theta);


npts = 100;
r0 = linspace(0,a,npts)';
r1 = linspace(a,b,npts)';
r2 = linspace(b,10,npts)';
phi = linspace(0,2*pi, npts)';

[R0, ~] = meshgrid(r0,phi); 
[R1, ~] = meshgrid(r1,phi); 
[R2, Phi] = meshgrid(r2,phi); 

P0 = V0(R0,Phi);  
P1 = V1(R1,Phi);  
P2 = V2(R2,Phi);  
sig1 = sig(R1,Phi);

[X0,Y0] = pol2cart(Phi,R0);
[X1,Y1] = pol2cart(Phi,R1);
[X2,Y2] = pol2cart(Phi,R2);

[EX0, EY0] = gradient(P0);
EX0 = -EX0;
EY0 = -EY0./R0;

[EX1, EY1] = gradient(P1);
EX1 = -EX1;
EY1 = -EY1./R1;

[EX2, EY2] = gradient(P2);
EX2 = -EX2;
EY2 = -EY2./R2;

DX0 = ep*2.*EX0;
DY0 = ep*2.*EY0;
D0 = sqrt(DX0.^2+DY0.^2);

DX1 = ep*2.*EX1;
DY1 = ep*2.*EY1;
D1 = sqrt(DX1.^2+DY1.^2);

DX2 = ep*2.*EX2;
DY2 = ep*2.*EY2;
D2 = sqrt(DX2.^2+DY2.^2);

%nexttile
%surfc(X0,Y0,P0)

%hold on
%surfc(X1,Y1,P1)
%hold off

%hold on
%surfc(X2,Y2,P2)
%hold off

%xlabel('X')
%ylabel('Y')
%zlabel('Potencial Eléctrico')
%title('Potencial Eléctrico')

%nexttile
%quiver(X0,Y0,EX0,EY0)
%hold on
%quiver(X1,Y1,EX1,EY1)
%hold off
%hold on
%quiver(X2,Y2,EX2,EY2)
%hold off
%xlabel('X')
%ylabel('Y')
%title('Campo Eléctrico')

%nexttile
%contourf(X0,Y0,P0)

%hold on
%contourf(X1,Y1,P1)
%hold off

%hold on
%contourf(X2,Y2,P2)
%hold off
%xlabel('X')
%ylabel('Y')
%title('Potencial Eléctrico')

%nexttile
%contourf(X1,Y1,sig1)
%xlabel('X')
%ylabel('Y')
%title('Densidad de Carga inducida en Esfera de R=a')
%colorbar

nexttile
quiver(X0,Y0,EX0,EY0)
hold on
quiver(X1,Y1,EX1,EY1)
hold off
hold on
quiver(X2,Y2,EX2,EY2)
hold off
xlabel('X')
ylabel('Y')
title('Campo Eléctrico')
set(gca,'Color','k')
axis([-10 10 -10 10])


