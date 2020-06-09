clc; clf; clear;
%Proyecto Teoria Electromagnetica
%Kenneth Aldana - 18435
%Voltaje en un tubo rectangular

%Declaro los valores iniciales
a = 1;
b = 2;
F = 0;
N = 2;
ep = (8.854187817)*(10.^(-12));

%Declaro el intervalor de los ejes X y Y
npts = 100;
xt = linspace(0,a,npts)';
yt = linspace(0,b,npts)';

%Creo una superficie con los puntos de X y Y anteriores
[X,Y] = meshgrid(xt,yt);
z = X;
%For funciona como un sumatorio
for n = 1:N
    %Declaro ecuacion a integrar / @(y) = integrar en y
    fun = @(y) sin(n*pi*y./b).*(5+(2*(y.^3)));
    %Integro desde 0 a b 
    v0 = integral(fun,0,b);
    v1 = 2./((exp(n*pi*a./b)).*b);
    %Le asigo un valor a Z que depende de la superficie previamente hecha
    Z = @(x,y) v0.*v1.*(exp(n*pi*x./b)).*(sin(n*pi*y./b));
    %Sumo el valor Z anterior con el Z actual para simular el sumatorio
    P = Z(X,Y);
    F = P+F;
end

%Encuentro el valor del Campo Electrico
[FX,FY] = gradient(F); 
FX = -FX;
FY = -FY;
FZ = ones(size(FX));

%Encuentro la densidad de carga
[DX,DY] = gradient(gradient(F));
DX = -ep.*DX;
DY = -ep.*DY;
D = DX+DY;

%Grafico las superficies y el diagrama de fase
tiledlayout(2,1)

nexttile
surf (X,Y,F);
hold on
quiver3(X,Y,F,FX,FY,FZ);
hold off
xlabel('X')
ylabel('Y')
zlabel('Potencial Eléctrico')
title('Potencial Eléctrico y Campo Eléctrico')
colorbar

nexttile
surf(X,Y,D)
xlabel('X')
ylabel('Y')
zlabel('Densidad de Carga')
title('Densidad de Carga')
colorbar
