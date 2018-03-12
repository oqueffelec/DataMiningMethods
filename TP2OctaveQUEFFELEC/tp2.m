%% 1
load iris.mat;
[valprop,U,moy] = mypca(x);
d=2;
[n,~] = size (x)
P=U(:,1:d);
Ct = projpca(x, moy, P);
Xhat = reconstructpca(Ct,P,moy);
err = 1/n * norm(x-Xhat, 'fro'); 

%% 2

load uspsasi.mat;
chiffre=8;
index=find(y==chiffre);
Xchiffre=x(index,:);

% trace

figure(1);
choix=21;
subplot(121), imagesc(reshape(Xchiffre(choix,:),16,16)'); colormap(gray); title('image originale')

% analyse de la correlation
figure(2);
imagesc(corrcoef(Xchiffre),colormap('autumn'),colorbar);


[valprop,U,moy] = mypca(x);
d = 2;
P= U(:,1:d);
Ct = projpca(x,moy,P);

figure(3)
plot(Ct(:,1),Ct(:,2),'.');