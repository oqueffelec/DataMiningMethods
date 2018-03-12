
% bout de code pour tracer la fronti�re de d�cision d'un SVM lin�aire 
% f(x) = w'*x = B
% W est le vecteur de param�tres du mod�le et b le terme de biais

figure(1)
N = 200;
[aux1,aux2]=meshgrid(linspace(-5,5,N));
aux=[reshape(aux1,N*N,1) reshape(aux2,N*N,1)];
fx = aux*w + b;
figure(1), hold on
% trace la frontiere de d�cision f(x) = 0 et la marge f(x)=1 et f(x)=-1
[c,h]=contour(aux1,aux2,reshape(fx, N,N), [-1 0 1], 'g', 'Linewidth',2);
clabel(c,h);