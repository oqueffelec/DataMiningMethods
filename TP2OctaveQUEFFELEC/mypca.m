function [valprop,U,moy] = mypca(X)

[n,~]=size(X);

moy=mean(X);

Xc = X-ones(n,1)*moy;

cov=1/n*Xc'*Xc;

[U,valprop] = eig(cov);

[valprop,index] = sort(diag(valprop),1,'descend');
U = U(:,index);



end