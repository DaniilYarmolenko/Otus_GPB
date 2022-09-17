import Foundation

// -MARK: Есть произвольный массив чисел, найти максимальное и минимальное число и поменять их местами

public func findMaxAndMin<T: Numeric & Comparable>( numbers: inout [T]) -> [T] {
    if numbers.count < 2 {
        return numbers
    }
    let maxIndex = numbers.firstIndex(of: numbers.max()!)
    let minIndex = numbers.firstIndex(of: numbers.min()!)
    (numbers[maxIndex!], numbers[minIndex!]) = (numbers[minIndex!], numbers[maxIndex!])
    return numbers
}

