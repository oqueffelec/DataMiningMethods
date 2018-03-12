clear all;
close all;
clc 
load 'uspsasi.mat';
%%

% On prends les 8 et les 1 ; 

posX1=(find(y==1));
posX2=(find(y==8));

X1=x(posX1,:);
X2=x(posX2,:);
X=[X1 ;X2];

Y=[y(posX1); y(posX2)];
Y(1:length(y(posX1)))=-1;
Y(length(y(posX1))+1:length(X))=1;

% % Split the data biatch
% rTest=1/3;
% rVal=1/3;
% method=1;
% [xapp, yapp, xtest, ytest, xval, yval] = my_splitData(X,Y, rTest, rVal, method);
% 
% %normailsation 
% [xapp,mapp,siga]=normalizemeanstd(xapp);
% xval=normalizemeanstd(xval,mapp,siga);
% xtest=normalizemeanstd(xtest,mapp,siga);

%% guidlines : split les donnees en apprentissage et test
ratio=2/3;
[Xa, Ya, Xtest, Ytest] = splitdata(X, Y, ratio);

%normalisation Xan
[Xan,Xtextn,meanxa,stdxa] = normalizemeanstd(Xa,Xtest); % ATTENTION normaliser Xv par rapport a Xa !! Normaliser toujours les donnees dapprentissage !


% Choix du C opt
vecteurC=logspace(-2,2,10);
for i=1:length(vecteurC)
    C=vecteurC(i);
    [w, b, alpha] = monsvmclass(Xan, Ya, C);
    
    %calcul erreru val
    ypred=monsvmval(Xtextn,w,b);
    erreurval(i)=mean(Ytest~=ypred);
    
    %calcul erreur app
    ypreda=monsvmval(Xan,w,b);
    erreurapp(i)=mean(Ya~=ypreda);
    
end

% trace des erreurs
semilogx(vecteurC,erreurval,'b--*'), hold on
% choix de Copt
[errvalmin,ind ]=min(erreurval);
Copt=vecteurC(ind);



