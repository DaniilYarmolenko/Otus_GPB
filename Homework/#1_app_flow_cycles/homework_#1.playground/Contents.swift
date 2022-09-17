import  Foundation

// -MARK: Description
/*
 Сгенерировать массив случайных чисел (например 200 чисел).
 Найти индекс первого повторяющегося числа в массиве.
 Если все числа разные – то -1.
 Пример : [3, 4, 5, 6, 8, 78, 67, 4, 88] - 4, индекс 1
 */

func makeRandomIntList(lenght n: Int, min: Int = 0, max: Int = 100) -> [Int] {
    /**
     This function returns a list of random integer
     
    **Parameters:**
        - lenght: lengh of result array .
        - min: lower bound of numbers
        - max: upper bound of numbers
    */
    (0..<n).map { _ in Int.random(in: min...max) }
}

func findFirstRepeatNumber(array:  [Int]) -> Int {
    /**
     This function returns the index of the first repeating number in the array. If there is no such number, it returns -1
     
    **Parameters:**
        - array: array of integer
    */
    if array.count < 2 {
        return -1
    }
    var dictionary: [Int:Int] =  [:]
    var minIndexRepeat = array.count
    var maxIndexRepeat = 0
    for index in 0..<array.count {
        if dictionary[array[index]] != nil {
            maxIndexRepeat = dictionary[array[index]]!
            if maxIndexRepeat < minIndexRepeat {
                minIndexRepeat = maxIndexRepeat
            }
        } else {
            dictionary[array[index]] = index
        }
    }
    if minIndexRepeat < array.count {
        return minIndexRepeat
    }
    return -1
}

// - MARK: testing
var randomArray = makeRandomIntList(lenght: 200, min: 0, max: 100)
let randomArrayString = """
---------------------------
Массив из рандомных целых чисел

\(randomArray)

"""
print(randomArrayString)

let resultFindRepeat = """
---------------------------
результат поиска

index = \(findFirstRepeatNumber(array: randomArray))

"""
print(resultFindRepeat)
