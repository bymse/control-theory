P =  [1 -1 0; 0 1 -1; 2 1 1];
Q = [0; 0; 1];
q = [-1; -1; -1];

Q_len = length(Q);

if kalman_condition(Q, P, Q_len)
    disp("критерий Калмана выполняется")
else 
    disp("критерий Калмана не выполняется")
end

c_polyn = poly(P);
fprintf("характеристический полином: %s\n", mat2str(c_polyn));

K = eye(Q_len);
for i = 1:Q_len
    K(i, i+1:end)=[c_polyn(2:Q_len-i+1)];
end
fprintf("K: %s\n", mat2str(K));

mnog = poly(q);
fprintf("характеристический многочлен: %s\n", mat2str(mnog));

gamma = c_polyn(1, 2:end) - mnog(1, 2:end);
fprintf("гамма: %s\n", mat2str(gamma));

disp("С:")
disp(gamma*(matrix*K)^(-1))

function met = kalman_condition(Q, P, n)
    matrix = Q;
    for c = 1:n
        m = P^c * Q;
        matrix = [matrix m];
        c = c + 1;
    end
    r = rank(matrix);
    met = r == n;
end