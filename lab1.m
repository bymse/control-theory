syms Q(t)
P = [0, 1; 0, 0];
Q = [t 0; 0 1];
f = [0;0];
T = 1;
x_0 = [1; 1];
x_1 = [0;1];

if kalman_condition_met(Q, P, length(x_0))
    fprintf("критерий Калмана выполняется\n");
else 
    fprintf("критерий Калмана не выполняется\n");
end

syms Y(t)
Y = expm(P*t);
fprintf("фундаментальная матрица: %s\n", char(Y));

syms B(t)
B = (Y^-1)*Q;
fprintf("B(t): %s\n", char(B));


A = int(B*B.', 0, T); %'
fprintf("A: %s:\n", char(A));

eta = subs(Y^(-1)*x_1-x_0-int(Y^(-1)*f,0, T), T);
fprintf("eta: %s\n", char(eta));

C = A^(-1)*eta;
u = (B.'* C); %'

fprintf("u(t): \n");
disp(u);

function met = kalman_condition_met(Q, P, n)
    matrix = Q;

    for c = 1:n
        m = P^c * Q;
        matrix = [matrix m];
        c = c + 1;
    end
    r = rank(matrix);
    fprintf("rank %s = %d\n", char(matrix), r);
    met = r == n;
end