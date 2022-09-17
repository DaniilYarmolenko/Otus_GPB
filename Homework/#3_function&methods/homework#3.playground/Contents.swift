import Foundation
// - MARK: Описание
/**
 *** Требования к функциям
 -  Функция складывает две целочисленных переменных - отдает на выходе сумму
 - Функция принимает кортеж из числа и строки приводит число к строке и ввыводит в консоль результат
 - Функция принимает на вход опциональное замыкание и целое число, выполняет замыкание только. в случае если число больше 0
 - Функция принимает число на вход (год), проверить високосный ли он
 *** Раскомментируйте необходимый фрагмент кода!
 */
// - MARK: Функция складывает две целочисленных переменных отдает на выходе сумму - sumTwoInteger

func sumTwoInteger(first: Int, second: Int) -> Int {first + second }
print(sumTwoInteger(first: 10, second: 20))

// - MARK: Функция принимает кортеж из числа и строки приводит число к строке и ввыводит в консоль результат - printCastIntToString

//func printCastIntToString(data: (Int, String)) {
//    print(data.1 + " \(data.0)")
//}
//printCastIntToString(data: (2,"номер"))

// - MARK: Функция принимает на вход опциональное замыкание и целое число, выполняет замыкание только. в случае если число больше 0 - checkClosure

//func checkClosure(closure: ( () -> Void)?, number: Int) {
//    if number > 0 {
//        (closure ?? {print("Пустой closure")})()
//    }
//}
//
//checkClosure(closure: nil, number: 10)
//
//checkClosure(closure: {printCastIntToString(data: ( 1,"Работа  closure"))}, number: 10)

// - MARK: Функция принимает число на вход (год), проверить високосный ли он - checkLeapYear

//func checkLeapYear(year: Int) -> Bool {
//    (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
//}
//
//
//var listLeapYear: [Int] = [2028, 133, 2024, 2020, 2016, 2012, 2008, 2004, 2000, 1996, 1992, 1988, 1984, 1980, 1976, 1972, 1968, 1964, 1960, 1956, 1952, 1948, 1944, 1940, 1936, 1932, 1928, 1924, 1920, 1916, 1912, 1908, 1904, 1900]
//
//listLeapYear.map {print("\($0) year is leap? - \(checkLeapYear(year: $0))")}
