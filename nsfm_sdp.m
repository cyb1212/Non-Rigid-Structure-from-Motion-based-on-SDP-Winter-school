% Pand Ji, Hongdong Li, Yuchao Dai, Ian Reid: "Maximizing Rigidity"
% Revisited: a Convex Programming Approach for Generic 3D Shape
% Reconstruction from Multiple Perspective Views, ICCV 2017.
%
%
function data=nsfm_sdp(data,opts)
%Normalize data
for k=1:length(data)
   x2d(:,:,k)=data(k).x2d; 
end
%Get parameters
Kneighbors = opts.Kneighbors; 
N=size(x2d,2);
M=size(x2d,3);

%Compute nbhood graph
IDX = getNeighborsMM(opts.nbGraph,x2d,Kneighbors);

for k=1:1:length(data)
    for i=1:1:size(x2d,2)%point number in one frame
        for j=2:1:size(IDX,2)
            ID1=IDX(i,1);
            ID2=IDX(i,j);
            cos_value{k,i,j}=x2d(1:3,ID1,k)'*x2d(1:3,ID2,k)/norm(x2d(1:3,ID1,k))/norm(x2d(1:3,ID2,k));
        end
    end
end

[mu] = NrSfM_cvx_sdp(IDX,x2d,cos_value);

%% Fill return variable
xl=sqrt(sum(x2d.^2,1));
for i=1:1:size(x2d,1)
    for j=1:1:size(x2d,2)
        x2d(i,j,:)=x2d(i,j,:)./xl(1,j,:);
    end
end
for k=1:length(data)
    data(k).x3d=repmat(reshape(mu(k,:)',1,N),[3,1]).*x2d(:,:,k);
end
end