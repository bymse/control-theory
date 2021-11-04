P =  [1 -1 0; 0 1 -1; 2 1 1];
Q = [0; 0; 1];
q = [-1; -1; -1]
disp("Проверяем критерий Калмана")
matrix = Q;
counter = 1;
while counter < length(Q)
        mult = P^counter * Q;
        matrix = [matrix mult];
        counter = counter + 1;
end
disp("rank")
disp(matrix)
disp("=")
disp(rank(matrix))
if rank(matrix)==length(Q)
    disp("Критерий Калмана выполняется")
else 
    disp("Критерий Калмана не выполняется")
end


% Строим характеристический полином
disp(P)
polynom = poly(P);
disp("Характеристический полином:")
disp(polynom)

% Строим К
disp("Матрица К:")
K = eye(length(Q));
for i = 1:length(Q)
    K(i,i+1:end)=[polynom(2:length(Q)-i+1)];
end
disp(K)

% Строим характеристический многочлен
mnog = poly(q);
disp("Характеристический многочлен:")
disp(mnog)


disp("Гамма:")
gamma = polynom(1, 2:end) - mnog(1, 2:end);
disp(gamma)

disp("Ответ:")
disp("C=")
disp(gamma*(matrix*K)^(-1))
