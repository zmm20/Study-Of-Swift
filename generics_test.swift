//
//  generics_test.swift
//  hello swift
//
//  Created by 周满满 on 4/1/16.
//  Copyright © 2016 周满满. All rights reserved.
//

import Foundation

func swapTwoValues<T>(inout a: T, inout _ b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

// 栈
struct Stack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}
extension Stack {
    var topItem: T? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

// 类型约束例子:
func findIndex<T : Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

// 关联类型举例
protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}
struct IntStack: Container {
    // IntStack的原始实现
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // 遵循Container协议的实现
    typealias ItemType = Int // 这句可以去掉
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

extension Array: Container {}
extension Stack: Container{
    // conformance to the Container protocol
    mutating func append(item: T) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> T {
        return items[i]
    }
}

// where
func allItemsMatch<C1: Container, C2: Container
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, anotherContainer: C2) -> Bool {
    
    // 检查两个Container的元素个数是否相同
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    // 检查两个Container相应位置的元素彼此是否相等
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    // 如果所有元素检查都相同则返回true
    return true
    
}


func GenericsTest(){
    var someInt = 3
    var anotherInt = 107
    swapTwoValues(&someInt, &anotherInt)
    print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
    // someInt 现在等于 107, anotherInt 现在等于 3
    
    print("Stack using,push 'uno', 'dos', 'tres', 'cuatro' to the Stack")
    var stackOfStrings = Stack<String>()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")
    stackOfStrings.push("cuatro")
    // 现在栈已经有4个string了
    let fromTheTop = stackOfStrings.pop()
    print("pop the value is :\(fromTheTop)");
    
    if let topItem = stackOfStrings.topItem {
        print("The top item on the stack is \(topItem).")
    }
    // 输出 "The top item on the stack is tres.”
    
    let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
    print("the index of 9.3 in [3.14159, 0.1, 0.25] is \(doubleIndex)")
    // doubleIndex is an optional Int with no value, because 9.3 is not in the array
    
    print("test equatable of two Containers:")
    let arrayOfStrings = ["uno", "dos", "tres"]
    if allItemsMatch(stackOfStrings, anotherContainer : arrayOfStrings) {
        print("All items match.")
    } else {
        print("Not all items match.")
    }
    // 输出 "All items match.”
    
    
}
