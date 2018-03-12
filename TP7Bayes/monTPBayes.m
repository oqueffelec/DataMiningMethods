
clear all
close all
clc
%% Generation de points gaussien
% Script � compl�ter pour r�alise le TP 

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
Y2 = 2*ones(n2, 1);



figure, plot(X1(:,1), X1(:,2), 'ro', 'markersize', 8, 'markerfacecolor', 'r')
hold on
plot(X2(:,1), X2(:,2), 'bv', 'markersize', 8, 'markerfacecolor', 'b')


% Dans la suite on ne travaillera qu'avec X et Y
% matrice des donn�es
X = [X1; X2]; clear X1 X2

% vecteur des labels
Y = [Y1; Y2]; clear Y1 Y2


%%  A COMPLETER : VOTRE IMPLEMENTATION DE LA LDA 

N=size(X,1);
N1=size(find(Y==1),1);
N2=size(find(Y==2),1);

pi1_apriori=N1/N;
pi2_apriori=N2/N;
mu1_apriori=mean(X(find(Y==1),:))';
mu2_apriori=mean(X(find(Y==2),:))';

sigma1_apriori=cov(X(find(Y==1),:));
sigma2_apriori=cov(X(find(Y==2),:));

sigma_apriori=(N1*sigma1_apriori+N2*sigma2_apriori)/N;

w=sigma_apriori\(mu2_apriori-mu1_apriori);
w0=0.5*mu2_apriori'*(sigma_apriori\mu2_apriori)-0.5*mu1_apriori'*(sigma_apriori\mu1_apriori)+log(pi1_apriori/pi2_apriori); % c'est b dans wtx-b



%% A DECOMMENTER : trace de la frontiere de decision de la LDA connaissant le vecteur w et le scalaire w0
M = 50;
% definition du maillage du plan
[auxdim1, auxdim2]=meshgrid(linspace(-8, 8, M)); 
auxdata = [reshape(auxdim1,M*M,1) reshape(auxdim2,M*M,1)]; 

% trace frontiere LDA
gx = auxdata*w + w0;
[c,h]=contour(auxdim1, auxdim2, reshape(gx,M,M), [0 0]);
set(h, 'linewidth', 2, 'color', 'g')
clabel(c,h)


%Calcul de l'erreur
ychap = maldaval(X,w,w0);
erreur=mean(Y~=ychap);

%% Exercice 2
clear all
close all
clc 
load astrodata.mat;

%guidlines : split les donnees en apprentissage et test
ratio=2/3;
[Xa, Ya, Xtest, Ytest] = splitdata(X, Y, ratio);

%normalisation Xan
[Xan,Xtestn,meanxa,stdxa] = normalizemeanstd(Xa,Xtest); % ATTENTION normaliser Xv par rapport a Xa !! Normaliser toujours les donnees dapprentissage !

%normalisation Xtn avec mua et sigma_a !!

%LDA

X=Xan;
Y=Ya;

N=size(X,1);
N1=size(find(Y==1),1);
N2=size(find(Y==2),1);

pi1_apriori=N1/N;
pi2_apriori=N2/N;
mu1_apriori=mean(X(find(Y==1),:))';
mu2_apriori=mean(X(find(Y==2),:))';

sigma1_apriori=cov(X(find(Y==1),:));
sigma2_apriori=cov(X(find(Y==2),:));

sigma_apriori=(N1*sigma1_apriori+N2*sigma2_apriori)/N;

w=sigma_apriori\(mu2_apriori-mu1_apriori);
w0=0.5*mu2_apriori'*(sigma_apriori\mu2_apriori)-0.5*mu1_apriori'*(sigma_apriori\mu1_apriori)+log(pi1_apriori/pi2_apriori); % c'est b dans wtx-b


% M = 50;
% % definition du maillage du plan
% [auxdim1, auxdim2]=meshgrid(linspace(-8, 8, M)); 
% auxdata = [reshape(auxdim1,M*M,1) reshape(auxdim2,M*M,1)]; 
% 
% % trace frontiere LDA
% gx = auxdata*w + w0;
% [c,h]=contour(auxdim1, auxdim2, reshape(gx,M,M), [0 0]);
% set(h, 'linewidth', 2, 'color', 'g')
% clabel(c,h)

%Calcul de l'erreur app
ychapa = maldaval(X,w,w0);
erreura=mean(Y~=ychapa);

%Calcul de l'erreur test
ychapt = maldaval(Xtestn,w,w0);
erreurt=mean(Ytest~=ychapt);
