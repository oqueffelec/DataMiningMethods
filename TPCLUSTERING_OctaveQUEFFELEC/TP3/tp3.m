close all;
clear all;
clc
%% CHA sur ds2

% on charge les donnees 

load 'ds2.dat';

step=16;
X = mydownsampling(ds2, step)

figure, plot(X(:,1), X(:,2), 'ro', 'markersize', 8, 'markerfacecolor', 'r')
hold on

% Calcul de la matrice de distance
M = distance(X);

% ========== CHA ===========
% -------- ultra-metrique : diametre maximal -------
method='complete'; 
level_max = aggclust(M, method);

% Affichage du dendogramme 
figure
dendro(level_max);
title('Clustering avec distance max', 'fontsize', 24)

K=2; % nombre de clusters voulus
% recuperation des indices des points de chaque cluster
N = size(X, 1);
clusters=level_max(N-K+1).cluster;

% trace des clusters obtenus
plotclusters(clusters, X, K);
title('Clustering avec distance max', 'fontsize', 24)

% ------- ultra-metrique : diametre min -------
method='single'; % saut minimal
level_min = aggclust(M, method);


% Affichage du dendogramme 
figure
dendro(level_min);
title('Clustering avec distance mix', 'fontsize', 24)

K=2; % nombre de clusters voulus
% recuperation des indices des points de chaque cluster
N = size(X, 1);
clusters=level_min(N-K+1).cluster;

% trace des clusters obtenus
plotclusters(clusters, X, K);
title('Clustering avec distance min', 'fontsize', 24)


%% CHA sur george

close all;
clear all;
clc

% on charge les donnees 

load 'george.dat';

step=10;
X = mydownsampling(george, step)

figure, plot(X(:,1), X(:,2), 'ro', 'markersize', 8, 'markerfacecolor', 'r')
hold on

% Calcul de la matrice de distance
M = distance(X);

% ========== CHA ===========
% -------- ultra-metrique : diametre maximal -------
method='complete'; 
level_max = aggclust(M, method);

% Affichage du dendogramme 
figure
dendro(level_max);
title('Clustering avec distance max', 'fontsize', 24)

K=6; % nombre de clusters voulus
% recuperation des indices des points de chaque cluster
N = size(X, 1);
clusters=level_max(N-K+1).cluster;

% trace des clusters obtenus
plotclusters(clusters, X, K);
title('Clustering avec distance max', 'fontsize', 24)

% ------- ultra-metrique : diametre min -------
method='single'; % saut minimal
level_min = aggclust(M, method);


% Affichage du dendogramme 
figure
dendro(level_min);
title('Clustering avec distance mix', 'fontsize', 24)

K=2; % nombre de clusters voulus
% recuperation des indices des points de chaque cluster
N = size(X, 1);
clusters=level_min(N-K+1).cluster;

% trace des clusters obtenus
plotclusters(clusters, X, K);
title('Clustering avec distance min', 'fontsize', 24)

%% K MEANS 
close all;
clear all;
clc

% on charge les donnees 

load 'george.dat';

step=10;
X = mydownsampling(george, step);

% X=george;

figure, plot(X(:,1), X(:,2), 'ro', 'markersize', 8, 'markerfacecolor', 'r')
hold on

nbclusters=6; 

% init des centres des clusters

K=nbclusters; % nbclusters
n=size(X,1);
index=randperm(n);
CO=X(index(1:nbclusters),:);

seuil=0.1;
[C,jw,clusters] = kmoyennes(X,CO,K,seuil);

% trace des clusters obtenus
plotclusters(clusters, X, K);
title('Clustering avec distance min', 'fontsize', 24)
