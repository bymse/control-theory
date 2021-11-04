% Построение программного управления
P = [0 0 0; 1 0 0; 0 1 0];
R = [0 0 1];
T = 1;
y = 2;

% Критерий Калмана
disp("Проверяем критерий Калмана")
matrix = transpose(R);
counter = 1;
while counter < length(R)
        mult = transpose(P)^counter * transpose(R);
        matrix = [matrix mult];
        counter = counter + 1;
end
disp("rank")
disp(matrix)
disp("=")
disp(rank(matrix))
if rank(matrix)==length(R)
    disp("Критерий Калмана выполняется")
else 
    disp("Критерий Калмана не выполняется")
end

% Фундаментальная матрица
disp ("Находим фундаментальную матрицу:")
syms Y(t)
Y(t) = expm(P*t);
disp (Y(t));

disp ("Находим H(t)")
syms H(t)
H(t)=R*Y(t);
disp (H(t));

disp ("Находим D:")
D = int(transpose(H)*H, 0, T);
disp (D);

disp ("Находим eta:")
eta = int(transpose(H)*y, 0, T);
disp (eta);

disp ("Находим x_0:")
x_0 = D^(-1)*eta;
disp (x_0);

disp ("Находим x(t):")
syms x(t)
x(t)= Y(t)*x_0;
disp (x(t));


