function [xapp, yapp, xtest, ytest, xval, yval] = my_splitData(X,Y, rTest, rVal, method)
    if method==1
        [xapp, yapp, xtest, ytest]=splitdata(X,Y,1-rTest);
        [xapp, yapp, xval, yval]=splitdata(xapp,yapp,1-rVal);
    else
        nbClass = length(unique(Y));
        % Trier les classes
        indT= [];
        indA= [];
        indV= [];
        ptDepart = 1;
        for i=1:nbClass
            l = length(find(Y==i)); % remplacer i par l'étiquette de la classe i
            indT = [indT, ptDepart:ceil(l*rTest)+ptDepart]; 
            ptDepart = ceil(l*rTest)+ptDepart+1;
            indV = [indV, ptDepart:ceil(l*rVal)+ptDepart];
            
            ptDepart = ceil(l*rVal)+ptDepart+1;
            if i~=nbClass
                ptFinal = min(find(Y==i+1))-1; % remplacer i par l'étiquette de la classe i
            else
                ptFinal = length(Y);
            end
            indA = [indA, ptDepart:ptFinal];
            ptDepart = ptFinal+1;
        end

        
        indT=uint16(indT);
        indA=uint16(indA);
        indV=uint16(indV);
        
        nT = length(indT);
        nA = length(indA);
        nV = length(indV);
        
        indT = indT(randperm(nT));
        indA = indA(randperm(nA));
        indV = indV(randperm(nV));
        
        xapp = X(indA,:);
        yapp = Y(indA);
        xtest = X(indT,:);
        ytest = Y(indT);
        yval = Y(indV);
        xval = X(indV,:);
        
        
    end
        
end

