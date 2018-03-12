

%% TP Birds
clear all
close all
clc

% Charger image : c'est une matrice 3D 128 x 128 x 3
bird = double(imread('bird_small.tiff'));

% dimensions
[Nlig, Ncol, d] = size(bird);

% transformer la matrice 3D en 2D avec chaque ligne repr�sentant les canaux
% RGB de chaque pixel ij de l'image
X = reshape(bird, Nlig*Ncol, d);


% ---------------- A COMPLETER AVEC VOTRE KMEANS ------------



nbclusters=6; 

% init des centres des clusters

K=nbclusters; % nbclusters
n=size(X,1);
index=randperm(n);
CO=X(index(1:nbclusters),:);

seuil=0.1;
[Centres,jw,clusters] = kmoyennes(X,CO,K,seuil);


%%
% ----------------------------------------------------------



% --------------- AFFICHAGE -------------------------
% --------- On suppose que les centres trouves sont dans la matrice Centres
Centres = round(Centres);

% afichage des centres des clusters
figure(1); hold on
for k=1:nbclusters
   col = (1/255).*Centres(k,:);
   rectangle('Position', [k, 0, 1, 1], 'FaceColor', col, 'EdgeColor', col);
end
axis off
hold off




% chargement de la grande image
large_image = double(imread('bird_large.tiff'));
figure(2)
imshow(uint8(large_image));
title('Image initiale', 'fontsize', 16)
%%

% on remplace directement dans l'image la valeur rgb du pixel par le centre
% le plus proche (pour sauver de place memorire)
[Nlig, Ncol, d] = size(large_image);
for i = 1:Nlig
    for j = 1:Ncol
        
        r = large_image(i,j,1); g = large_image(i,j,2); b = large_image(i,j,3);
        x = [r, g, b]; % on recupere les valeurs RGB du pixel ij
        
        % ---------------- A COMPLETER  ------------
        
        for k=1:nbclusters
            dist(k)=norm(x-Centres(k,:));
        end
        [tmp,indice]=min(dist);
        large_image(i,j,:)=Centres(indice,:);
        
        
%         large_image(i,j,:) = centre le plus proche
    end 
end
% on affiche l'image apres encodage avec Kmeans 
figure(3)
imshow(uint8(large_image));
title('Encodage de l''image via Kmeans', 'fontsize', 16)
