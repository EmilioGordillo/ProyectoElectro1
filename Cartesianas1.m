clc; clf; clear;
%Proyecto Teoria Electromagnetica
%Kenneth Aldana - 18435
%Voltaje en un tubo rectangular

%Declaro los valores iniciales
a = 1;
b = 2;
F = 0;
N = 20;
ep =(8.854187817)*(10.^(-12));

%Declaro el intervalor de los ejes X y Y
npts = 100;
xt = linspace(0,a,npts)';
yt = linspace(0,b,npts)';

%Creo una superficie con los puntos de X y Y anteriores
[X,Y] = meshgrid(xt,yt);

%For funciona como un sumatorio
for n = 1:N
    %Declaro ecuacion de a integrar / @(y) = integrar en y
    fun = @(y) sin(n*pi*y./b).*(atan(y./a));
    %Integro desde 0 a b 
    v0 = integral(fun,0,b);
    v1 = 2./(b*sinh(n*pi*a./b));
    %Le asigo un valor a Z que depende de la superficie previamente hecha
    Z = @(x,y) v0.*v1.*(sinh(n*pi*x./b)).*(sin(n*pi*y./b));
    %Sumo el valor Z anterior con el Z actual para simular el sumatorio
    P = Z(X,Y);
    F = P+F;
end
%Encuentro el valor del Campo Electrico
[FX,FY] = gradient(F); 
FX = -FX;
FY = -FY;
FZ = sqrt(FX.^2+FY.^2);

%Encuentro la densidad de carga
[DX,DY] = gradient(gradient(F));
DX = -ep.*DX;
DY = -ep.*DY;
D = DX+DY;

%Grafico las superficies y el diagrama de fase
tiledlayout(3,1)

nexttile
surf (X,Y,F);
title('Potencial Eléctrico')
xlabel('X')
ylabel('Y')
zlabel('Potencial Eléctrico')
colorbar

nexttile
surf(X,Y,D)
title('Densidad de Carga')
xlabel('X')
ylabel('Y')
zlabel('Densidad de Carga')
colorbar

nexttile
quiver3(X,Y,F,FX,FY,FZ);
xlabel('X')
ylabel('Y')
title('Campo Eléctrico')
set(gca,'Color','k')
axis([0 1 0 2])

