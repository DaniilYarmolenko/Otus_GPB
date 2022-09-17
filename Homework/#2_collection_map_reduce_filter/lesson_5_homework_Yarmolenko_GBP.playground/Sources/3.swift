import Foundation
// -MARK: Создать словарь с соотношением имя (ключ) пользователя - пароль (значение), получить из словаря все имена, пароли которых длиннее 10 символов


public func findUserWithLongPassword (userLoginPassword:[String: String]) -> [String] {
    userLoginPassword.filter { $0.value.count > 10 }.map { $0.key }
}
