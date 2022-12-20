# Homework #15
## GCD: очереди
Преподаватель [Сергей Балалаев][Teacher]

### Цель:
 _Применение serial и concurrent очередей, понимание barrier, разбираться_

#### Описание/Пошаговая инструкция выполнения домашнего задания:
1. Исследуйте код ниже и напишите, какие цифры должны вывестись в консоль, обьясните своими словами, почему именно такая последовательность по шагам.
```sh
    func testQueue(){
        print("1")
        DispatchQueue.main.async {
            print("2")
            DispatchQueue.global(qos: .background).sync {
                print("3")
                DispatchQueue.main.sync {
                    print("4")
                    DispatchQueue.global(qos: .background).async {
                        print("5")
                    }
                    print("6")
                }
                print("7")
            }
            print("8")
        }
        print("9")
    }
```
2. Создайте свою сериюную очередь и замените в примере ей DispatchQueue.main, создайте свою конкурентную очередь и заменить ей DispatchQueue.global(qos: .background). Какой будет результат? Всегда ли будет одинаковым И почему?
3. Какой по номеру надо поменять sync/sync чтобы не возникало дедлока в обоих случаях
4. Как можно сделать в примере, чтобы очередь превратилась из конкурентной в серийную, подправте пример не исправляя создания самой очереди




[Teacher]: <https://career.habr.com/sergey-balalaev>

[rep]: <https://github.com/DaniilYarmolenko/Otus_GPB/tree/homework/Homework/>



