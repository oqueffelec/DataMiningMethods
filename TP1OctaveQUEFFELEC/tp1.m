%% 1 

load WhiteW.mat;
moyx=mean(X);
stdx=std(X);
moyy=mean(Y);
stdy=std(Y);
% var=var(X,1);
boxplot(X);
% imagesc(corrcoef(X),colorbar, 'Matrice de corr'); % la var 4 et 8 sont assez corelle





%% 2 

% Decoupage des données 

ratio=2/3;
ratio2=1/2;
[Xa, Ya, Xtest, Ytest] = splitdata(X, Y, ratio);
[Xa, Ya, Xv, Yv] = splitdata(Xa, Ya, ratio2);

% k plus proches voisins 

kvec=1:2:35;
DistApp=[];
DistVal=[];
DistTest=[];
for i=1:length(kvec)
    k=kvec(i);
    [YaPred, DistApp]=kppv(Xa, Xa, Ya, k, DistApp);
    [YvPred, DistVal]=kppv(Xv, Xv, Ya, k, DistVal);
    [YtPred, DistTest]=kppv(Xtest, Xtest, Ya, k, DistTest); % ATTENTION à ne pas faire c'est de la triche
    
    errorapp(i)=mean(Ya~=YaPred);
    errorval(i)=mean(Yv~=YvPred);
    errortest(i)=mean(Ytest~=YtPred);
end
figure
plot(kvec,errorapp,'*--b',kvec,errorval,'+-r', kvec, errortest,'s-m');
set(gca,'XDir','reverse','fontsize', 18);
xlabel('Valeurs decroissantes de k');
ylabel('Erreur empirique de classification');
legend('Remp APP', 'Rem VAL', 'Remp test');
title('Sans la normalisation');

% se fier à la courbe d"eval pour la meilleur val de k
% choix du k optimal

[Errvalmin, index]=min(errorval);
fprintf('erreur de val min = %2.2f', Errvalmin)
fprintf('K optimal = %d', kvec(index))

%%

% Decoupage des données 

ratio=2/3;
ratio2=1/2;
[Xa, Ya, Xtest, Ytest] = splitdata(X, Y, ratio);
[Xa, Ya, Xv, Yv] = splitdata(Xa, Ya, ratio2);

% on decide de normaliser pour que les distances aient un sens
[Xa,Xv,meanxa,stdxa] = normalizemeanstd(Xa,Xv); % ATTENTION normaliser Xv par rapport a Xa !! Normaliser toujours les donnees dapprentissage !
[~, Xtn] = normalizemeanstd(Xa,Xtest,meanxa,stdxa);
% k plus proches voisins 

kvec=1:2:35;
DistApp=[];
DistVal=[];
DistTest=[];
for i=1:length(kvec)
    k=kvec(i);
    [YaPred, DistApp]=kppv(Xa, Xa, Ya, k, DistApp);
    [YvPred, DistVal]=kppv(Xv, Xv, Ya, k, DistVal);
    [YtPred, DistTest]=kppv(Xtest, Xtest, Ya, k, DistTest);
    
    errorapp(i)=mean(Ya~=YaPred);
    errorval(i)=mean(Yv~=YvPred);
    errortest(i)=mean(Ytest~=YtPred);
end
figure
plot(kvec,errorapp,'*--b',kvec,errorval,'+-r', kvec, errortest,'s-m');
set(gca,'XDir','reverse','fontsize', 18);
xlabel('Valeurs decroissantes de k');
ylabel('Erreur empirique de classification');
legend('Remp APP', 'Rem VAL', 'Remp test');
title('Avec la normalisation');


