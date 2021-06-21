function [mu,D]=NrSfM_addPoints(IDX2,m2Mat,m1Mat,mu1,D1)

N = size(m2Mat,2);
M = size(m2Mat,3);
L = size(IDX2,2);

import mosek.fusion.*;
Mdl   = Model('trustMeYourAreAwesome');
Z     = Mdl.variable('Z', [M,N], Domain.greaterThan(0.0));
D     = Mdl.variable('D', [L-1,N],Domain.greaterThan(0.0)); 
alpha = Mdl.variable('alpha',1,Domain.greaterThan(0.0)); 

for i = 1:N % for each point
    diV  =  Var.flatten(Var.repeat(D.slice([1,i],[L,i+1]),1, M));
    ziV3 =  Var.repeat(Var.repeat(Z.slice([1,i],[M+1,i+1]),L-1),1,3); 
    xiML = repmat(permute(m2Mat(:,i,:),[1,3,2])',L-1,1);
    xjML = reshape(permute(m1Mat(:,IDX2(i,2:end),:),[1,3,2]),3,M*(L-1))';      
    mZ1  = mu1(:,IDX2(i,2:end));
    
    zjV3 = repmat(mZ1(:),1,3);
    Mdl.constraint(Expr.hstack(diV,Expr.sub(Expr.mulElm(ziV3,xiML),Expr.mul(alpha,zjV3.*xjML))), Domain.inQCone());
end

Mdl.constraint(Expr.add(Expr.mul(alpha,sum(sum(D1))),Expr.sum(D)),Domain.equalsTo(1));
Mdl.objective(ObjectiveSense.Maximize, Expr.add(Expr.mul(alpha,sum(sum(mu1))),Expr.sum(Z)));

Mdl.solve();
aV = alpha.level();
mu = reshape(Z.level()/aV,N,M)';
D  = reshape(D.level()/aV,L-1,N)';
end
