Модуль itertools  подробнее на https://python-scripts.com/itertools
 <pre>
 Опытное применение:
 s = [-5, -9, 4, 5]   найти 3 числа сумма которых равна нулю
 
 itertools.combinations(iterable, [r]) - комбинации длиной r из iterable без повторяющихся элементов.
  combinations('ABCD', 2) --> AB AC AD BC BD CD 
  
  Решение:
  
   import itertools as it
    s = [5, 4, -9, 3, 5]
    for  i in it.combinations(s, 3):
    if sum(i) == 0:
        print(i)
        break
 </pre>
