clear all;
close all;
clc;
%% Exercice 1
%% generation des donnees

randn('state', 1200)

% G�n�ration des donn�es
vmu1 = [0; 2];
vmu2 = [-2; -1];
vSIGMA1 = 1.5*[1 0.1; 0.1 1];
vSIGMA2 = 3.5*[1 -0.25; -0.25 1/2];


n1 = 100; % nombre de points classe 1
n2 = 150; % nombre de points classe 2

% generation de donnees aleatoires suivant lois gaussiennes
% classe 1
X1 =  mvnrnd(vmu1, vSIGMA1,n1);   
Y1 = ones(n1, 1);
% classe 2
X2 =  mvnrnd(vmu2, vSIGMA2,n2);    
Y2 = 0*ones(n2, 1);


figure, plot(X1(:,1), X1(:,2), 'ro', 'markersize', 8, 'markerfacecolor', 'r')
hold on
plot(X2(:,1), X2(:,2), 'bv', 'markersize', 8, 'markerfacecolor', 'b')


% Dans la suite on ne travaillera qu'avec X et Y
% matrice des donn�es
X = [X1; X2]; clear X1 X2

% vecteur des labels
Y = [Y1; Y2]; clear Y1 Y2

%% Prediction
lambda=1e-6; % ATTENTION ! ne pas mettre lambda=0 et ne pas mettre epsilon =eps
epsilon=1e-3;
Maxiter=100000;
[theta, allJ] = reglogclass(X, Y, lambda, epsilon, Maxiter);
ypred = reglogval(X, theta);



%% Frontiere
% bout de code pour tracer la fronti�re de d�cision d'un mod�le de
% r�gression logistique en 2D. 
% theta est le vecteur de param�tres du mod�le

figure(1)
M = 200;
[aux1,aux2]=meshgrid(linspace(-5,5,M));
aux=[reshape(aux1,M*M,1) reshape(aux2,M*M,1)];
Score = [ones(M*M, 1) aux]*theta;
figure(1), hold on
[c,h]=contour(aux1,aux2,reshape(Score, M,M), [0 0], 'g', 'Linewidth',2);
clabel(c,h);

%% Exercice 2
clear all;
close all;
clc;
load('mnist-app.mat');
load('mnist-test.mat');
%% On choisis 2 chiffres: le 8 et 3

X1=Xa(find(Ya==3),:);
X2=Xa(find(Ya==8),:);
X=[X1;X2];
Y=[0*ones(size(X1,1),1);1*ones(size(X2,1),1)];

%on normalise
ratio=2/3;
[Xa, Ya, Xtest, Ytest] = splitdata(X, Y, ratio);

%normalisation Xan
[Xan,Xtextn,meanxa,stdxa] = normalizemeanstd(Xa,Xtest);


%% Prediction
lambda=1e-3; % ATTENTION ! ne pas mettre lambda=0 et ne pas mettre epsilon =eps
epsilon=1e-3;
Maxiter=20;
[theta, allJ] = reglogclass(Xan, Ya, lambda, epsilon, Maxiter);
ypred = reglogval(Xan, theta);

%calcul de l'erreur
erreura=mean(Ya~=ypred);


