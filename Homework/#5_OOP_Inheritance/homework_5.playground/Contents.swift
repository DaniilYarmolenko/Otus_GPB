/**
 #### Описание/Пошаговая инструкция выполнения домашнего задания:
 - В Playground реализуйте некоторый базовый класс из выбранной вами области описания (тематики).
 - Добавьте в него свойства и методы, а также несколько инициализаторов. Класс должен содержать свойства и методы разной области видимости (private, fileprivate, internal или public)
 - Создайте несколько классов-наследников. Переопределите при необходимости свойства и методы родителя. А также добавьте свои.
 - В основном пространстве Playground создайте функцию для демонстрации полиморфизма.
 - К заданию приложите либо архив с Playground, либо ссылку на гитхаб репозиторий, куда загрузите код.

 #### Критерии оценки:
 - Факт сдачи - 40 баллов
 - Есть базовый класс и хотя бы 1 класс наследник - 20 баллов
 - Показаны различные модификатора доступа - 10 баллов
 - Есть переопределенные свойства и методы - 10 баллов
 - Есть пример полиморфизма - 10 баллов
 */

import UIKit
class Employee {
    var name: String
    var hobbe: String?
    var salary: [Double]
    init(name: String, hobbe: String? = nil, salaryMonth: [Double]) {
        self.name = name
        self.hobbe = hobbe
        self.salary = salaryMonth
    }
    private func calcAvarageSalary() -> Double{ salary.reduce(0, +)/Double(salary.count) }
    var description: String {
        return """
            Описание работника:
            Имя работника: \(name)
            Хобби работника: \(hobbe ?? "-")
            Средняя зарплата: \(calcAvarageSalary())
        """
    }
}

class Manager: Employee {
    var projectsCount: Int
    init(name: String, hobbe: String? = nil, salaryMonth: [Double], projectsCount: Int = 0) {
        if projectsCount < 0 {
            self.projectsCount = 0
        } else {
            self.projectsCount = projectsCount
        }
        super.init(name: name, hobbe: hobbe, salaryMonth: salaryMonth)
    }
    func addWork() {
        print("Найти обычных работников и следить за их работой")
        addProject()
    }
    func checkWork() {
        print("Проверка работы обычных сотрудников")
    }
    func acceptWork() {
        if projectsCount > 0 {
        print("Принять работу сотрудника")
        removeProject()
        }
    }
    private func addProject(){
        projectsCount += 1
    }
    private func removeProject(){
        projectsCount -= 1
    }
    override var description: String {
        return """
\(super.description)
    Количество проектов: \(projectsCount)
"""
    }
}

class Boss: Manager {
    var budgetYear: Double
    
    init(name: String, hobbe: String? = nil, salaryMonth: [Double], projectsCount: Int = 0, budjet: Double) {
        self.budgetYear = budjet
        super.init(name: name, hobbe: hobbe, salaryMonth: salaryMonth, projectsCount: projectsCount)
    }
    override func addWork() {
        print("Ищу менеджера....")
        while !checkBudjet(money: Double.random(in: 0...1000)) {
            print("Этот много просит")
            print("Ищу менеджера....")
        }
        print("Этот достаточно")
    }
    override func checkWork() {
        print("Проверяю работу менеджера")
    }
    override func acceptWork() {
        print("Принимаю работу менедджера")
        gettingMoney()
    }
    override var description: String {
        return """
\(super.description)
    Годовой бюджет: \(budgetYear)
"""
    }
    private func checkBudjet(money: Double) -> Bool {
        if budgetYear - money > 0 {
            budgetYear -= money
            return true
        }
        return false
    }
    private func gettingMoney() {
        let money = Double.random(in: 0...1000)
        budgetYear += money
    }
}

// -MARK: Обычный работник
var empl1 = Employee(name: "Jack", salaryMonth: [22, 321, 20 ,32, 201, 12])
print(empl1.description)

// -MARK: Менеджер проектов
// Переопределено свойство description
var manager = Manager(name: "Mike", hobbe: "Fishing", salaryMonth: [12, 3000, 3040, 102, 303], projectsCount: 0)
manager.addWork()
manager.checkWork()
manager.acceptWork()

print(manager.description)
// -MARK: Начальник
// Переопределены методы
//Полиморфизм - свойство description

var boss = Boss(name: "Alex", salaryMonth: [434, 4320,12310 ,23002 ,2030], budjet: 300)
boss.addWork()
boss.checkWork()
boss.acceptWork()
print(boss.description)
