function [mu]=NrSfM_template(IDX,D,mMat)

if(size(IDX,1)~=size(mMat,2))
   printf('Wrong number of pts'); 
end

N = size(mMat,2);
M = size(mMat,3);
L = size(IDX,2);
vM = 1:M;

import mosek.fusion.*;
Mdl = Model('trustMeYouAreAwesome');
Z = Mdl.variable('Z', [M,N], Domain.greaterThan(0.0));


for i = 1:N % for each point
  
    Dij=repmat(D(i,2:end)',1,M)';
    diV  =  Dij(:);
    ziV3 =  Var.repeat(Var.repeat(Z.slice([1,i],[M+1,i+1]),L-1),1,3);    
    mID  = repmat(IDX(i,2:end),M,1);
    idxN = [repmat(vM',L-1,1), mID(:)];
    xiML = repmat(permute(mMat(:,i,:),[1,3,2])',L-1,1);
    xjML = reshape(permute(mMat(:,IDX(i,2:end),:),[1,3,2]),3,M*(L-1))';
    
    zjV3 = Var.repeat(Z.pick(idxN),1,3);    
    Mdl.constraint(Expr.hstack(Expr.constTerm(diV),Expr.sub(Expr.mulElm(ziV3,xiML),Expr.mulElm(zjV3,xjML))), Domain.inQCone());
%            
%     if size(idxN,1)>1
%         zjV3 = Var.repeat(Z.pick(idxN),1,3);    
%         Mdl.constraint(Expr.hstack(Expr.constTerm(diV),Expr.sub(Expr.mulElm(ziV3,xiML),Expr.mulElm(zjV3,xjML))), Domain.inQCone());
%     else
% %         zjV3 = Var.repeat(Z.pick(idxN(1),idxN(2)),1,3);       
% %         Mdl.constraint(Expr.hstack(Expr.constTerm([diV;diV]),Expr.sub(Expr.mulElm(Expr.vstack(ziV3,ziV3),[xiML;xiML]),Expr.mulElm(Expr.vstack(zjV3,zjV3),[xjML;xjML]))), Domain.inQCone());
%     end
    
    
    
end

%%

% accs=Mdl.getAcceptedSolutionStatus;
% Mdl.acceptedSolutionStatus(accs.Anything)
Mdl.objective(ObjectiveSense.Maximize, Expr.sum(Z));

Mdl.solve();
mu = reshape(Z.level(),N,M)';
%D  = reshape(D.level(),N,L-1)';
end
