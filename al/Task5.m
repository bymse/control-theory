% % Тест на проверку определения положительных вещественных чисел
% P =  [1 -2 0; 0 -1 0; 1 1 2];
% Q = [0; 0; 1];
P =  [-1 0 0 1; 0 -1 1 -1; 1 1 0 0; -1 0 0 0];
Q = [0;0;1;0];
q = [-1; -2];
% ____________________________________________________________
% ШАГ 1
% ____________________________________________________________
disp("Проверяем систему на полную управляемость")
S = Q;
counter = 1;
while counter < length(Q)
        mult = P^counter * Q;
        S = [S mult];
        counter = counter + 1;
end
if rank(S)==length(Q)
    disp("Используй Task4.m")
    return
else 
    disp("rank")
    disp(S)
    disp("=")
    disp(rank(S))
end

% ____________________________________________________________
% ШАГ 2
% ____________________________________________________________
% Строим матрицу T
T = eye(length(Q))
while rank(builtT(T,P, Q,S))~=length(Q)
%     Перемешиваем столбцы в случайном порядке
    T = T(randperm(size(T, 1)), :);
end
disp("Матрица T = ")
disp(T)

% ____________________________________________________________
% ШАГ 3
% ____________________________________________________________
disp("Матрица P с волной")
P_wave = T^(-1)*P*T;
disp(P_wave)

disp("Разделяем блоки:")
[P11 P12 P22] = separateBlocks(P_wave);
disp("P11 = ")
disp(P11)
disp("P12 = ")
disp(P12)
disp("P22 = ")
disp(P22)

disp("Рассматриваем собственные числа P22")
disp(eig(P22))
eigP = eig(P22)
for i=1:length(eigP)
    if eigP(i,:)>=0
        disp("Не все вещественные части собственных чисел отрицательны => система не стабилизируема")
        return
    end
end


% ____________________________________________________________
% ШАГ 4
% ____________________________________________________________
disp ("Строим K1")
K_1 = eye(length(P11));
P11_rot = -transpose(rot90(rot90(P11)));
for i = 1:length(P11)
    K_1(i,i+1:end)=P11_rot(i, 1:length(P22)-i);
end
disp(K_1)

% ____________________________________________________________
% ШАГ 5
% ____________________________________________________________
disp("Строим эталонный полином")
mnog = poly(q);
disp("Характеристический многочлен:")
disp(mnog)

% ____________________________________________________________
% ШАГ 6
% ____________________________________________________________
gamma_1 = P11_rot(1, 1:length(K_1)) - mnog(1, 2:end);
gamma_2 = zeros(1:length(P)-length(gamma_1));
Gamma = [gamma_1 gamma_2]

% ____________________________________________________________
% ШАГ 7
% ____________________________________________________________
K = [K_1 zeros(size(K_1, 1), length(P)-size(K_1, 2));
    zeros(length(P)-size(K_1, 1), size(K_1, 2)) eye(length(P)-size(K_1, 1),  length(P)-size(K_1, 2))]

disp("ОТВЕТ: ")
c = Gamma*(T*K)^(-1)

% __________________________________________________________________
% Всякие нужные (и ненужные) функции
function [P11 P12 P22] = separateBlocks(P)
string = 0;
column = 0;
for i = 2:length(P)
%     Идем по строкам
    if P(i,1)==0
%         Ищем первый нулевой элемент
        string = i
        for j = 1:length(P)
%             Идем по столбцам в этой строке
            if P(string, j)==0
                column = j;
%                 Ищем первый нулевой элемент
                  for k = string:length(P)
%                       Смотрим все эементы под ним
                        if P(k, j)~=0
                            column = j -1;
                            break
                        end
                  end

            end
        end
        break
    end
end
P11 = P(1: string-1, 1:column);
P12 = P(1:string-1,column+1:end);
P22 = P(string:end, column+1:end);
end
% #################################################
function T_new = builtT (T,P, Q,S)
for i=0:rank(S)-1
    mult = P^i * Q;
    T(:,i+1) = transpose(mult);
end
T_new = T;

end