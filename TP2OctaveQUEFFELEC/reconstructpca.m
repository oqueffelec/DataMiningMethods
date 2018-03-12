function Xhat = reconstructpca( C,P,moy )
[n,~]=size(C);
Xhat = C*P' + ones(n,1)*moy;

end

