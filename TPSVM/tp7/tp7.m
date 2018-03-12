clear all;
close all;
clc 
%%
%load 'uspsasi.mat';
%Generation des données
vmu1 = [0; 0];
vmu2 = [2; 2];
vSIGMA1 = [1 0.5; 0.5 4];
vSIGMA2 = vSIGMA1;


n1 = 100; % nombre de points classe 1
n2 = 100; % nombre de points classe 2

% generation de donnees aleatoires suivant lois gaussiennes
% classe 1
X1 =  mvnrnd(vmu1, vSIGMA1,n1);   
Y1 = -ones(n1, 1);
% classe 2
X2 =  mvnrnd(vmu2, vSIGMA2,n2);    
Y2 = ones(n2, 1);
k=[0.01 0.1 1 12 30 100];
C=k(2)*ones(n1+n2,1);

x = [X1; X2]; 
y = [Y1; Y2]; 

posX1=find(y==-1);
posX2=find(y==1);

figure(1)
plot(x(posX1,1), x(posX1,2), 'ro', 'markersize', 8, 'markerfacecolor', 'r')
hold on
plot(x(posX2,1), x(posX2,2), 'bv', 'markersize', 8, 'markerfacecolor', 'b')
title('Vérité vraie du prophète Talim Zalout')

clear X1 X2
clear Y1 Y2



[w, b, alpha] = monsvmclass(x, y, C);

%%
ypred=monsvmval(x,w,b);
figure(1)
N = 200;
[aux1,aux2]=meshgrid(linspace(-5,5,N));
aux=[reshape(aux1,N*N,1) reshape(aux2,N*N,1)];
fx = aux*w + b;
figure(1), hold on
% trace la frontiere de d�cision f(x) = 0 et la marge f(x)=1 et f(x)=-1
[c,h]=contour(aux1,aux2,reshape(fx, N,N), [-1 0 1], 'g', 'Linewidth',2);
clabel(c,h);
erreur =mean(y~=ypred)


%% Itération sur le C
for j=1:length(k)
    

C=k(j)*ones(n1+n2,1);
[w, b, alpha] = monsvmclass(x, y, C);
ypred=monsvmval(x,w,b);


    figure(2)
    subplot(3,3,j)

plot(x(posX1,1), x(posX1,2), 'ro', 'markersize', 8, 'markerfacecolor', 'r')
hold on
plot(x(posX2,1), x(posX2,2), 'bv', 'markersize', 8, 'markerfacecolor', 'b')
title(['Ci=',num2str(k(j)),' erreur=',num2str(erreur)]);

figure(2)
N = 200;
[aux1,aux2]=meshgrid(linspace(-5,5,N));
aux=[reshape(aux1,N*N,1) reshape(aux2,N*N,1)];
fx = aux*w + b;
erreur =mean(y~=ypred)
figure(2), hold on
% trace la frontiere de d�cision f(x) = 0 et la marge f(x)=1 et f(x)=-1
[c,h]=contour(aux1,aux2,reshape(fx, N,N), [-1 0 1], 'g', 'Linewidth',2);
clabel(c,h);
    
end

%%


