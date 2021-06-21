% CVX
s = pwd;
% cd .\cvx
strcat(pwd,'\cvx')
cvx_setup
cd(s)
%% Geodesic lib
global geodesic_library;
geodesic_library = 'geodesic_matlab_api';      %"release" is faster and "debug" does additional checks

%% Set path
addpath(genpath('.'));
