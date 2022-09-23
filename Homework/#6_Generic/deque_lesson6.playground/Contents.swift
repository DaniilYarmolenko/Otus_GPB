/**
 #### Описание/Пошаговая инструкция выполнения домашнего задания:
 - Реализуйте дженерик-класс для структуры данных Stack, Deque или Queue.
 - Класс должен содержать дженерик-методы согласно выбранному типу структуры данных.
 - В Playground основном пространстве напишите пример с использованием созданного класса

 #### Критерии оценки:
 - Факт сдачи - 40 баллов
 - Реализация класса выбранного типа - 30 баллов
 - Пример с использованием - 20 баллов
 
 ### Deque:
 Двусвязная очередь (жарг. дэк, дек от англ. deque — double ended queue; двусторонняя очередь, очередь с двумя концами) — абстрактный тип данных, в котором элементы можно добавлять и удалять как в начало, так и в конец. Может быть реализована при помощи двусвязного списка.

 ## Типовые операции:
 PushBack — добавление в конец очереди.
 PushFront — добавление в начало очереди.
 PopBack — выборка с конца очереди.
 PopFront — выборка с начала очереди.
 IsEmpty — проверка наличия элементов.
 Clear — очистка.
 */

struct Deque <Element> {
    var elements = [Element]()
    var isEmpty: Bool { elements.isEmpty }
    var count: Int { elements.count }
    var seekBack: Element? {
        return elements.last
    }
    var seekFront: Element? {
        return elements.first
    }
    
    mutating func pushBack(_ element: Element) {
        elements.append(element)
    }
    mutating func pushFront(_ element: Element) {
        elements.insert(element, at: 0)
    }
    mutating func popBack() -> Element? {
        isEmpty ? nil : elements.removeLast()
    }
    mutating func popFront() -> Element? {
        isEmpty ? nil : elements.removeFirst()
    }
    
    
    mutating func clearAll() {
        elements.removeAll()
    }
}

// -MARK: Пример

var firstDeque = Deque(elements: [1, 2, 3, 4, 5, 6])
print(firstDeque.elements)
print(firstDeque.seekFront ?? "нет элемента") // печатает первый элемент, если он есть
print(firstDeque.seekBack ?? "нет элемента") // печатает последний элемент, если он есть
firstDeque.pushBack(100) // добавляет элемент в конец
firstDeque.pushFront(-20) // добавляет элемент в начало
print(firstDeque.elements)

print(firstDeque.popBack() ?? "нет элемента") // удаляет и возвращает элемент с конца очереди, если есть такой элемент
print(firstDeque.popFront() ??  "нет элемента") // удаляет и возвращает элемент с начала очереди, если есть такой элемент
print(firstDeque.elements)

firstDeque.clearAll() // очищает очередь
print(firstDeque.elements)
