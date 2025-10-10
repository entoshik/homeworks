import numpy as np
# 1. Вам представлен код с реализацией алгоритма Нидлмана-Вунша. Функция needleman_wunsch принимает параметры: match=2, mismatch=-1, gap=-1
# поэксперементируйте с параметрами и посморите, как меняется выравнивание и score. Какие выводы можно сделать?
# Ксли увеличть mismatch=-1, то теперь штраф за несовпадение выше, поэтому алгоритм будет предпочитать gaps вместо несовпадений.

## 2. Используя numpy создайте матрицу 7 на 7
matrix = np.random.random(49).reshape(7, -1)
print(matrix)

# 3. NumPy: создайтие диагональную матрицу, где по главной диагонали идут числа от 1 до 5
matrix = np.diag(np.arange(1,6))
print(matrix)

# 4. Напиши функцию, которая принимает матрицу и проверяет, является ли она единичной. В ответе возвращается True или False
def matrix_is_eye(matrix):
    if (matrix == np.eye(matrix.shape[0])).all():
        return True
    return False

print(matrix_is_eye(np.eye(6)))