A = [1 1; 0 1];
syms Y(t)
Y(t) = expm(P*t);
disp(Y(t));