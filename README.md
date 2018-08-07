# Coranking matrix
Assessing quality of dimensionality reduction by coranking matrix based method. Reference:

> 1. Lee, John A., and Michel Verleysen. "Quality assessment of dimensionality reduction: Rank-based criteria." Neurocomputing 72.7-9 (2009): 1431-1443.

> 2. Mokbel, Bassam, et al. "Visualizing the quality of dimensionality reduction." Neurocomputing 112 (2013): 109-123.


### Usage
1. Add file `coranking.m` into Matlab search path

2. Enter original data **X** and dimensionality reduced map **Y**, then function `coranking` computes:
   - Ranking matrix **R** of X,
   - Ranking matrix **r** of Y,
   - Coranking matrix **C** based on **R, r**,
   - Quality index matrix **Q_NX** proposed in Ref. 1,
   - Improved quality index matrix **Q_ND** proposed in Ref. 2.

   Only need one line in Matlab: `[R, r, C, Q_NX, Q_ND] = coranking(X, Y)`. 


### Examples
1. Use random matrices for X, Y. In Matlab:
```
N = 6000;       % sample number
n = 100;        % original data dimension (features)
m = 2;          % reduced data dimension (features)

% use random X, Y
X = rand(N, n); 
Y = rand(N, m);
[R, r, C, Q_NX, Q_ND] = coranking(X, Y);
```
<img src="https://github.com/HHTseng/Coranking-matrix/blob/master/example1_random/random_results.png" width="800">

<!-- Example 1                  |  random map results 
:-------------------------:|:-------------------------:
![](https://github.com/HHTseng/Coranking-matrix/blob/master/example1_random/Q_NX.png)  |  ![](https://github.com/HHTseng/Coranking-matrix/blob/master/example1_random/Q_ND.png) -->


2. File `MNIST_tSNE_N6000.mat` provides a real dimensionality map using t-SNE on [MNIST](https://en.wikipedia.org/wiki/MNIST_database) with 6,000 handwritten digits.

```
load('./example2_tpSNE/MNIST_tSNE_N6000.mat')
[R, r, C, Q_NX, Q_ND] = coranking(X, Y);
```

<img src="https://github.com/HHTseng/Coranking-matrix/blob/master/example2_tpSNE/tSNE_results.png" width="1200">


3. File `MNIST_pSNE_N6000.mat` provides a real dimensionality map using [p-SNE](https://ieeexplore.ieee.org/document/7952576/) on [MNIST](https://en.wikipedia.org/wiki/MNIST_database) with 6,000 handwritten digits.

```
load('./example2_tpSNE/MNIST_pSNE_N6000.mat')
[R, r, C, Q_NX, Q_ND] = coranking(X, Y);
```

<img src="https://github.com/HHTseng/Coranking-matrix/blob/master/example2_tpSNE/pSNE_results.png" width="1200">


The above matices **Q_NX** and **Q_ND** are plotted by the following command in Matlab:

```
% plot Q_NX
N = size(X, 1);    % sample size
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
```
