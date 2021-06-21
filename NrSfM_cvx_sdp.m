function [mu]=NrSfM_cvx_sdp(IDX,mMat,cos_value)
N = size(mMat,2);%point number in one frame
M = size(mMat,3);%image number
L = size(IDX,2);%edge number in one frame for one point

point_num=M*N;
edge_num=(L-1)*N*M;
edge_num_oneframe=(L-1)*N;
lamda=0.5;

cvx_begin
    variable Y(point_num,point_num) symmetric;% rank 1 matrix Y
    variable l(point_num) nonnegative;% all distances between 3D points to camera centre
    variable d(edge_num) nonnegative;% all distances between 3D points
    variable g(edge_num_oneframe) nonnegative;% upper bound for all distances between 3D points
    minimize trace(Y)-sum(l)-lamda*sum(d);
    subject to

cvx_end
mu = reshape(l,N,M)';
