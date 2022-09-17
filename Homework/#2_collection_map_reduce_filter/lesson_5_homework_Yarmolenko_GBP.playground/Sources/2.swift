import Foundation
// -MARK: Есть два массива символов - собрать результирующее множество из символов, что повторяются в 2х массивах

public func findCharacterSet(firstArray: [Character], secondArray: [Character]) -> Set<Character>{ Set(firstArray).intersection(Set(secondArray)) }
