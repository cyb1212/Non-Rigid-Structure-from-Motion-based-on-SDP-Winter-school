%% Copyright (C) 2020 by Yongbo Chen

%This code is used to re-implement a non-rigid structure from motion based on
%semi-definite programming (SDP)
%% Reset environment
clc;
clear all;
close all;
warning off;
%% Setup solvers
prompt = 'Have you installed CVX? Y/N [Y]: ';
str = input(prompt,'s');
if isempty(str)
    error('Plesea answer the question ');
else
    if str == 'Y'
    else
        setup();
    end
end


%% Load dataset

% Downsample for complex methods
opts.sv=1;          %subsample pts
opts.sp=1;          %subsample views
opts.normalizeK=1;  %normalize with known intrinsics

% Hulk example
% dataset=prepare_hulk(opts);
% dataset.data.x2d:      2D input points
% dataset.data.x3d_gt:   3D points (Ground truth)
% dataset.K:             Calibaration result
% dataset.imageSize:     Image size
% dataset.N:             Points number
% dataset.M:             Images number
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Flag example
% dataset=prepare_flag(opts);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tshirt
dataset=prepare_tshirt_reduced(opts);
data=dataset.data;        %Input and ground truth
imSize=dataset.imageSize; %Image size
N=dataset.N;              %Points number
M=dataset.M;              %Images number
%% Set reconstruction parameters
options=getDefaultOptions();
rec_tlmdh=nsfm_sdp(data,options.tlmdh);
%% Evaluate reconstruction
[res_tlmdh, ~,err3d_tlmdh,err_p]=evaluate(rec_tlmdh,1:M,options.tlmdh);
mean(err3d_tlmdh);
mean(err_p);
% plot results
for i=1:M
     figure,
    plot3(res_tlmdh(i).x3d_aligned(1,:),res_tlmdh(i).x3d_aligned(2,:),res_tlmdh(i).x3d_aligned(3,:),'go');
    hold on;
    plot3(res_tlmdh(i).x3d_gt(1,:),res_tlmdh(i).x3d_gt(2,:),res_tlmdh(i).x3d_gt(3,:),'ro');
    hold off;
    axis equal;
end
mean(mean(err_p))
