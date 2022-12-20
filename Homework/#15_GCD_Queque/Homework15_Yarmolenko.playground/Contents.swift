import UIKit

/*MARK: - task 1
 Исследуйте код ниже и напишите, какие цифры должны вывестись в консоль, обьясните своими словами, почему именно такая последовательность по шагам.
*/
func testQueue() {
    print("1") // Выводится первым, так как фуннкция синхронная и задача первая
    
    DispatchQueue.main.async {
        print("2") // Выводится третьим, так как асинхронная функция ждет выполнения всех синхронных задач
        
        DispatchQueue.global(qos: .background).sync {
            print("3") // Выводится третим, так как функция ассинхронная и ждет выполнения других задач в синхроном потоке
            
            DispatchQueue.main.sync { // блок с данной задачой не выполняется из-за дедлока sync на sync
                print("4")
                
                DispatchQueue.global(qos: .background).async { // блок с данной задачей не выполняется так как внешний блок не выполняется из-за deadlock
                    print("5")
                }
                print("6") // такая же проблема как и с 4
            }
            
            print("7") // не выполняется задача, так как ждет выполнения блока, который в deaddlock
        }
        
        print("8") // не выполняется задача, так как ждет выполнения блока, который в deaddlock
    }
    
    print("9") // Выводится вторым, так как задача синхронная и самая первая
}

//testQueue()
/*
         1, 9, 2, 3
 1 - Выводится первым, так как фуннкция синхронная и задача первая
 9 - Выводится вторым, так как задача синхронная и самая первая
 2 - Выводится третим, так как функция ассинхронная и ждет выполнения других задач в синхроном потоке
 3 - Выводится третьим, так как асинхронная функция ждет выполнения всех синхронных задач
 
 
 4 - блок с данной задачой не выполняется из-за дедлока sync на sync
 5 - блок с данной задачей не выполняется так как внешний блок не выполняется из-за deadlock
 6 - такая же проблема как и с 4
 7 - не выполняется задача, так как ждет выполнения блока, который в deaddlock
 8 - не выполняется задача, так как ждет выполнения блока, который в deaddlock

 
 */



/*MARK: - task 2
 Создайте свою сериюную очередь и замените в примере ей DispatchQueue.main,
 создайте свою конкурентную очередь и заменить ей DispatchQueue.global(qos: .background).
 Какой будет результат? Всегда ли будет одинаковым И почему?
*/
let serialQueue = DispatchQueue(label: "serialQueue")
let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)

func printSerialConcurrentQueue() {
    
    print("1")
    
    serialQueue.async {
        print("2")
        
        concurrentQueue.sync {
            print("3")
            
            serialQueue.sync { // блок с данной задачой не выполняется из-за дедлока sync на sync
                print("4")
                
                concurrentQueue.async {
                    print("5")
                }
                print("6")
            }
            
            print("7") // Не выведется в консоль из-за deadlock'а выше.
        }
        
        print("8") // Не выведется в консоль из-за deadlock'а выше.
    }
    
    print("9")
}

//printSerialConcurrentQueue()
/*
         
 Результат отличен от первой задачи. Известно только лишь, что 1 выведится первым в консоль, так как выполняется синхронно, остальные результаты (2, 3, 9)
 - в любом прядке, так результат serial ассинхронной очереди непредсказуем
 Ошибки из-за deadlock такие же
 
 */
/*MARK: - task 3
 Какой по номеру надо поменять sync/sync чтобы не возникало дедлока в обоих случаях
*/

func noDeadlock() {
    print("1")
    
    DispatchQueue.main.async {
        print("2")
        
        DispatchQueue.global(qos: .background).sync {
            print("3")
            
            DispatchQueue.main.async {
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
//noDeadlock()
//    Необходимо изменить третий блок кода, то есть второй sync, какк показано в коде выше

/*MARK: - task 3
 Как можно сделать в примере, чтобы очередь превратилась из конкурентной в серийную, подправте пример не исправляя создания самой очереди
*/

func changeConcurrentToSerialQueue() {
    
    print("1")
    
    serialQueue.async(flags: .barrier) {
        print("2")
        
        concurrentQueue.sync {
            print("3")
            
            serialQueue.sync { // блок с данной задачой не выполняется из-за дедлока sync на sync
                print("4")
                
                concurrentQueue.async {
                    print("5")
                }
                print("6")
            }
            
            print("7") // Не выведется в консоль из-за deadlock'а выше.
        }
        
        print("8") // Не выведется в консоль из-за deadlock'а выше.
    }
    
    print("9")
}

//changeConcurrentToSerialQueue()

// Чтобы изменить серийную в конкуретную, необходимо добавить  флаг .barrier
