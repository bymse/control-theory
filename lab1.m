P = [1, 1; 0, 1];
Q = [0;1];
f = [0;0];
T = 1;
x_0 = [0;0];
x_1 = [1;1];

can_be = can_be_controlled(Q, P, length(x_0));
disp('Критерий Калмана:');
if can_be
    disp('выполняется');
else
    disp('не выполняется');
end
syms Y(t)
Y(t) = expm(P*t);
syms B(t)
B(t) = (Y(t)^-1)*Q;
A = int(B * B.', 0, T);
eta = (Y(T)^-1)*x_1 - x_0 - int((Y(t)^-1) * f, 0, T);
C = (A^-1)*eta;
u = B'*C;
disp('u(t):');
disp(u);


function can_be = can_be_controlled(Q, P, n)
    matrix = Q;
    counter = 0;
    while counter < n
        mult = P^counter * Q;
        matrix = [matrix mult];
        counter = counter + 1;
    end
    can_be = rank(matrix) == n;
end
