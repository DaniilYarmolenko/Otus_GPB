/**
 #### Описание/Пошаговая инструкция выполнения домашнего задания:
 Напишите несколько примеров и функций:
 1. Функция, принимающая функцию как параметр
 2. Функция с несколькими замыканиями
 3. Функция с autoclosure
 4. Использование внутренних функций
 5. Дженерик-функция с условием

 В Playground добавьте пример для демонстрации работы.

 #### Критерии оценки:
 - Факт сдачи - 40 баллов
 - Функция, принимающая функцию как параметр - 10 баллов
 - Функция с несколькими замыканиями - 10 баллов
 - Функция с autoclosure - 10 баллов
 - Использование внутренних функций - 10 баллов
 - Дженерик-функция с условием - 10 баллов
 - Наличие примера - 10 баллов
 */

// MARK: Функция, принимающая функцию (замыкание) как параметр. Калькулятор


typealias DoubleFunction = (Double, Double) -> Double?
func calculatingTwoDouble(_ first: Double, _ second: Double, operation: DoubleFunction) -> Double? { operation(first, second) }
var sumTwoDouble: DoubleFunction = { $0 + $1 }
var subtractionTwoDouble: DoubleFunction = {$0 - $1}
var multiplyTwoDouble: DoubleFunction = {$0 * $1}
var divisionTwoDouble: DoubleFunction = {
    if $1 == 0 {
        print("Error, division by zero")
        return nil
    } else {
        return $0/$1
    }
}

// Работа калькулятора. Можно добалять самописные замыкания/функции, а можно  использовать операторы

print(calculatingTwoDouble(55, 10, operation: +) ?? "Что-то не то") //65.0
print(calculatingTwoDouble(55, 10, operation: -) ?? "Что-то не то")
print(calculatingTwoDouble(55, 0, operation: /) ?? "Что-то не то") // inf - что не очень правильно
print(calculatingTwoDouble(55, 0, operation: divisionTwoDouble) ?? "Error")


// MARK: Функция с несколькими замыканиями. Загрузка данных из сети
class User {
    var name: String
    var email: String
    init(name: String = "Unknown name", email: String){
        self.name = name
        self.email = email
    }
}
func loadUserFromURL(url: String, comletion: (User) -> Void, onFailure: () -> Void) {
    if let user = downloadDataFromURL(url) {
        comletion(user)
    } else {
        onFailure()
    }
}

func downloadDataFromURL(_ url: String) -> User? {
    for i in 0...100 where i%10 == 0 {
        print("Идет загрузка с \(url)...  \(i)% / 100%")
    }
    return User(name: "Рандомно", email: "random@random.ru")
}

loadUserFromURL(url: "www.downloadUser.com/api/v1") { user in
    print("Загрузка успешно завершена")
    print("Юзер № \(Int.random(in: 0...10000)). Имя - \(user.name), email - \(user.email)" )
} onFailure: {
    print("Загрузка завершилась ошибкой!")
}

// MARK: Функция с autoclosure - сахар. С ним не пишем фигурные скобки для closure
func exampleWithoutAutoclosure(_ downloadUser: () -> Void) {
    print("Для примера мы запускаем загрузку user ")
    downloadUser()
    print("Получилось")
}

exampleWithoutAutoclosure {
    for i in 0...100 where i%10 == 0 {
        print("Идет загрузка \(i)% / 100%")
    }
}

exampleWithoutAutoclosure {
    print("идет загрузка....")
}


func exampleWithAutoclosure(_ downloadUser:  @autoclosure () -> Void) {
    print("Для примера мы запускаем загрузку user ")
    downloadUser()
    print("Получилось")
}

exampleWithAutoclosure(print("идет загрузка...."))


// MARK: Использование внутренних функций

func printLoadData(url: String) {
    print("Вызываем загрузку данных c \(url)")
    loadData(url)
    print("Загрузила данные")
    func loadData(_ url: String) {
        (0...100).filter{$0 % 10 == 0}.map{ print ("Загружаю данные с \(url).... \($0)% / 10%")}
    }
}
printLoadData(url: "www.example.ru/api/v1/load%20data")

//MARK: - Дженерик-функция с условием. Поисккэлемента в коллекции


func search<element, col> (_ value: element, in col: col) -> Bool where element: Comparable, col: Collection {
    for item in col {
        if item as? element == value {
            print("find")
            return true
        }
    }
    print("Not find")
    return false
}

let first = search(10, in: [0, 20 ,302, 10 ,2030, 20])
print(first)
// равнозначно
func searchSecondVersion<element: Comparable, col: Collection> (_ value: element, in col: col) -> Bool {
    for item in col {
        if item as? element == value {
            print("find")
            return true
        }
    }
    print("Not find")
    return false
}

let second = searchSecondVersion("a", in: ["s","a"])
print(second)
