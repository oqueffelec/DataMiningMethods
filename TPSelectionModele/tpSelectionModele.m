clear all
close all
clc
%%
load letter.mat;
load letter_test.mat;


Xa=data_letter;
Ya=label_letter;
Xt=data_test_letter;
Yt=label_test_letter;
% on choisi c et d 
Xa_1=Xa(find(Ya==3),:);
Xa_2=Xa(find(Ya==4),:);

Ya_1=ones(length(find(Ya==3)),1);
Ya_2=-ones(length(find(Ya==4)),1);

% de meme pour le test
Xt_1=Xt(find(Yt==3),:);
Xt_2=Xt(find(Yt==4),:);

Yt_1=ones(length(find(Yt==3)),1);
Yt_2=-ones(length(find(Yt==4)),1);
 

%%
Xa=[Xa_1;Xa_2];
Ya=[Ya_1;Ya_2];
Xt=[Xt_1;Xt_2];
Yt=[Yt_1;Yt_2];


%normalisation Xan
[Xan,Xtextn,meanxa,stdxa] = normalizemeanstd(Xa,Xt); % ATTENTION normaliser Xv par rapport a Xa !! Normaliser toujours les donnees dapprentissage !


% Choix du C opt
vecteurC=logspace(-2,2,10);
for i=1:length(vecteurC)
    C=vecteurC(i);
    [w, b, alpha] = monsvmclass(Xan, Ya, C);
    
    %calcul erreru val
    ypred=monsvmval(Xtextn,w,b);
    erreurval(i)=mean(Yt~=ypred);
    
    %calcul erreur app
    ypreda=monsvmval(Xan,w,b);
    erreurapp(i)=mean(Ya~=ypreda);
    
end

% trace des erreurs
semilogx(vecteurC,erreurval,'b--*'), hold on
% choix de Copt
[errvalmin,ind ]=min(erreurval);
Copt=vecteurC(ind);
%%
monroc(ypred, Yt);
% monroc(ypreda, Ya);

%% Reg log ATTENTION label 0 et 1 (et pas -1 et 1)

[theta, allJ] = reglogclass(X, Y, lambda, epsilon, Maxiter);



%% Matrice confusion 

Z_svm=()

% testcholdout(Y_svm,Y_reglog,Ytest);
