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
Z1 = X;

v1 = 4./(b*a);

%For funciona como un sumatorio
for m = 1:N
    for n = 1:N
        %Declaro ecuacion de a integrar / @(y) = integrar en y
        fun = @(x,y) (x.*(y.^2)).*(sin(m*pi.*x./a)).*(sin(n*pi.*y./b));
        %Integro desde 0 a b 
        v0 = integral2(fun,0,a,0,b);
        %Le asigo un valor a Z que depende de la superficie previamente hecha
        Z = @(x,y) v0.*v1.*exp(-Z1.*pi.*(sqrt(((m./a).^2)+((n./b).^2)))).*(sin(m*pi*x./a)).*(sin(n*pi*y./b));
        %Sumo el valor Z anterior con el Z actual para simular el sumatorio
        P = Z(X,Y);
        F = P+F;
    end
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
title('Potencial y Campo Eléctrico')
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

