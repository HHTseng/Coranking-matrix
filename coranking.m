function [R, r, C, Q_NX, Q_ND] = coranking(X, y)

N = size(X,1);   % total samples
D = pdist2(X,X); % distances of high-dim data
d = pdist2(y,y); % distances of low-dim data

% Step 1: Compute ranking matrix R_ij, r_ij
t1_start = tic;  % counting time
R = uint32(zeros(N,N)); r = uint32(zeros(N,N));
for i=1:N
    % Sort for the i-th row of D and d resp.
    [~, ind_D] = sort(D(i,:));
    [~, ind_d] = sort(d(i,:));
    
    R(i, ind_D) = (0:N-1);
    r(i, ind_d) = (0:N-1);
end

t1 = toc(t1_start);
fprintf('Ranking matrix computed in: %.2f sec\n', t1);


% Step 2: Compute coranking matrix C_ij
t2_start = tic;  % counting time

C = uint32(zeros(N,N));
for i=1:N
    for j=1:N
        if R(i,j)>=1 && R(i,j)<=N && r(i,j)>=1 && r(i,j) <= N
            C(R(i,j),r(i,j)) = C(R(i,j),r(i,j)) + 1;
        end
    end
end

t2 = toc(t2_start);
fprintf('Coranking matrix computed in: %.2f sec\n', t2);


% Step 3: Compute Q_NX
t3_start = tic;  % counting time
Q_NX = zeros(1, N);

% Q_NX(k=1)
q = double(C(1,1));
Q_NX(1) = q / N;

% Q_NX(k > 1)
for k=2:N
    q = q + sum(double(C(1:k, k))) + sum(double(C(k, 1:k))) - double(C(k,k));
    Q_NX(k) = q / (k*N);
end
t3 = toc(t3_start);

fprintf('Quality index Q_NX computed in: %.2f sec\n', t3);



% Step 4: Compute Q_ND(ks,kt)
t4_start = tic;  % counting time
Q_ND_noscaling = zeros(N,N);
for ks = 1:N
    % vector csum(kt): the contribution of sum in the ks-th row of matrix C,
    % within the columns [ks - kt, ks + kt]
    csum = zeros(1, N);
    
    % Compute csum(1)
    csum(1) = C(ks, ks);
    ind = ks + 1;
    if ind <= N
        csum(1) = csum(1) + C(ks, ind);
    end
    ind = ks - 1;
    if ind >= 1
        csum(1) = csum(1) + C(ks, ind);
    end
    
    % Compute csum(kt) using csum(kt-1)
    for kt=2:N
        csum(kt) = csum(kt - 1);
        ind = ks + kt;
        if ind <= N
            csum(kt) = csum(kt) + C(ks, ind);
        end
        ind = ks - kt;
        if ind >= 1
            csum(kt) = csum(kt) + C(ks, ind);
        end
    end
    
    if ks == 1
        Q_ND_noscaling(ks,:) = csum;
    else
        Q_ND_noscaling(ks,:) = Q_ND_noscaling(ks-1,:) + csum;
    end
end

Q_ND = Q_ND_noscaling ./ (repmat((1:N)', [1,N]) * N);
t4 = toc(t4_start);

fprintf('Quality index Q_ND computed in: %.2f sec\n', t4);





