% Построение программного управления
P = [0 0 0; 1 0 0; 0 1 0];
R = [0 0 1];
T = 1;
y = 2;

if kalman_condition(P, R)
    fprintf("критерий Калмана выполняется\n");
else 
    fprintf("критерий Калмана не выполняется\n");
end

syms Y(t) x(t) H(t)

Y = expm(P*t);
fprintf("фундаментальная матрица: %s\n", char(Y));

H = R*Y;
fprintf("H(t): %s\n", char(H));

D = int(H.'*H, 0, T); %'
fprintf("D: %s\n", char(H));

eta = int(H.'*y, 0, T); %'
fprintf("eta: %s\n", char(eta));

x_0 = D^(-1)*eta;
fprintf("x_0: %s\n", char(x_0));

x= Y*x_0;
fprintf("x(t): %s\n", char(x));

function met = kalman_condition(P, R)
    matrix = R.'; %'
    n = length(R);
    for c = 1:n
        m = (P.')^c * R.';
        matrix = [matrix m];
    end
    r = rank(matrix);
    met = r == n;
end