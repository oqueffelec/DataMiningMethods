function [ychap] = maldaval(Xv,w,b)
ychap=zeros(size(Xv,1),1);
fv=Xv*w-b;
ychap(fv<0)=1;
ychap(fv>0)=2;

end

