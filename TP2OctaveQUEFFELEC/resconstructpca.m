function Xhat = resconstructpca( C,P,moy )
[n,~]=size(P);
Xhat = C*P' + ones(n,1)*moy';

end

