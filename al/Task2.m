syms Q(t)
P = [0, 1; 0, 0];
Q = [t 0; 0 1];
f = [0;0];
T = 1;
x_0 = [1; 1];
x_1 = [0;1];

disp("Проверяем критерий Калмана")
matrix = Q;
counter = 1;
while counter < length(x_0)
        mult = P^counter * Q;
        matrix = [matrix mult];
        counter = counter + 1;
end
disp("rank")
disp(matrix)
disp("=")
disp(rank(matrix))
if rank(matrix)==length(x_0)
    disp("Критерий Калмана выполняется")
else 
    disp("Критерий Калмана не выполняется")
end






disp ("Находим фундаментальную матрицу:")
syms Y(t)
Y(t) = expm(P*t);
disp (Y(t));

disp("Строим B(t)")
syms B(t)
B(t) = (Y(t)^-1)*Q;
disp (B(t));


disp("Строим A(t)")
A = int(B(t)*transpose(B(t)), 0, T);
disp(A)

disp("Строим eta")
eta = Y(T)^(-1)*x_1-x_0-int(Y(t)^(-1)*f,0, T);
disp(eta)

C = (A^(-1))*eta;
u = transpose(B(t))*C;

disp("Ответ")
disp('u(t):');
disp(u);