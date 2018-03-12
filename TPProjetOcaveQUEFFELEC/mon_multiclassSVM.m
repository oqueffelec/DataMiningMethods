clear all
close all
clc
%% DM Projet Octave QUEFFELEC
%% Multi class SVM
load 'astrodataall.mat';

%% 1/ nombre de points par classe 

nb_1=length(find(Y==1));
nb_2=length(find(Y==2));
nb_3=length(find(Y==3));

%% 2/ Normalisation & split

ratio=2/3;
ratio2=0.05;
[Xa, Ya, Xtest, Ytest] = splitdata(X, Y, ratio);
[Xa, Ya, Xv, Yv] = splitdata(Xa, Ya, ratio2);

% on decide de normaliser pour que les distances aient un sens
[Xa,Xv,meanxa,stdxa] = normalizemeanstd(Xa,Xv); % ATTENTION normaliser Xv par rapport a Xa !! Normaliser toujours les donnees dapprentissage !
[~, Xtest] = normalizemeanstd(Xa,Xtest,meanxa,stdxa);

%% 3/ Phase d'apprentissage
nb=3;
%%  1 against 2 & 3
Ya1=Ya;
Ya1(Ya1==2)=-1;
Ya1(Ya1==3)=-1;

% SVM lineaire 
x=Xa;
y=Ya1;
C=1;
[w1, b1, alpha] = monsvmclass(x, y, C);
ypred=monsvmval(x,w1,b1);
erreur1 =mean(y~=ypred);

%% 2 against 1 & 3
Ya2=Ya;
Ya2(Ya2==1)=-1;
Ya2(Ya2==3)=-1;
Ya2(Ya2==2)=1;


% SVM lineaire 
x=Xa;
y=Ya2;
C=1;
[w2, b2, alpha] = monsvmclass(x, y, C);
ypred=monsvmval(x,w2,b2);
erreur2 =mean(y~=ypred);

%% 3 against 1 & 2
Ya3=Ya;
Ya3(Ya3==1)=-1;
Ya3(Ya3==2)=-1;
Ya3(Ya3==3)=1;


% SVM lineaire 
x=Xa;
y=Ya3;
C=1;
[w3, b3, alpha] = monsvmclass(x, y, C);
ypred=monsvmval(x,w3,b3);
erreur3 =mean(y~=ypred);

%% Phase de test
nb=3;
f1=w1'*Xtest'+b1;
f2=w2'*Xtest'+b2;
f3=w3'*Xtest'+b3;
F=[f1;f2;f3];
[val ypred]=max(F);

ypred=ypred';

%% Matrice de confusion 
ytrue=Ytest;
cm = confusionmatrice(ytrue, ypred)
erreur=1-sum(diag(cm))/sum(sum(cm))







