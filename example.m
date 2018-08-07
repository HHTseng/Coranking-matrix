% Given high-dim data X: Nxn matrix
%        low-dim  map y: Nxm matrix (usually m <= n)
%       where N = sample size, n=original feature dim, m = reduced feature dim
clear; clc; close all;

% Example 1
N = 6000;       % sample number
n = 100;        % original data dimension (features)
m = 2;          % reduced data dimension (features)

% use random X, Y
X = rand(N, n); 
Y = rand(N, m);
[R, r, C, Q_NX, Q_ND] = coranking(X, Y);

% plot Q_NX
figure
plot(1:N, Q_NX(1:N));
title('Q_{NX}(K)');
xlabel('K', 'FontSize', 12); ylabel('Q_{NX}(K)', 'FontSize', 12);

% plot Q_ND
figure
imagesc(Q_ND);
colormap('hot'); colorbar;
title('Q_{ND}(K_s, K_t)');
xlabel('K_t', 'FontSize', 12); ylabel('K_s', 'FontSize', 12);

%% Example 2
load('./example2_tpSNE/MNIST_tSNE_N6000.mat')  % load real dimension reduction map
[R, r, C, Q_NX, Q_ND] = coranking(X, Y);

% plot Q_NX
figure
plot(1:N, Q_NX(1:N));
title('Q_{NX}(K)');
xlabel('K', 'FontSize', 12); ylabel('Q_{NX}(K)', 'FontSize', 12);

% plot Q_ND
figure
imagesc(Q_ND);
colormap('hot'); colorbar;
title('Q_{ND}(K_s, K_t)');
xlabel('K_t', 'FontSize', 12); ylabel('K_s', 'FontSize', 12);
