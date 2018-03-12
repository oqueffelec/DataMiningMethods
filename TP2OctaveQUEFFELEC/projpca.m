function Ct = projpca(X, moy, P)
[n,~]=size(X);
[d,~]=size(P);
Xc = X-ones(n,1)*moy;
Ct=Xc*P;
end