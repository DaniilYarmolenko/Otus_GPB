import Foundation
// - MARK: First task
var numbers = [1, 2, 4, 2, 0, 5, 3, 10, 200, 320, -123]
let resultFirst = """
---------------------------
Результат первого задания \

\(findMaxAndMin(numbers: &numbers))

"""
print(resultFirst)
// - MARK: Second task
let resultSecond = """
---------------------------
Результат второго задания \

\(findCharacterSet(firstArray: ["a","b","f","f","l","/","A","B"], secondArray: ["a","b","o","1", "A"]))
----------------------------
"""
print(resultSecond)

// - MARK: Third task

let resultThird = """
---------------------------
Результат третьего задания \

\(findUserWithLongPassword(

userLoginPassword: [
    "user1": "0123456789",
    "user2": "01234567891011",
    "user3": "0123456",
    "user4": "0123456789214",
    "user5": "0123789",
    "user6": "0123456789sdfsd",
    "user7": "0123489",
    "user8": "0123456789qdwqd",
    "user9": "01234589",
    "user10": "01234567dwqd89"
    ]))
----------------------------
"""
print(resultThird)
