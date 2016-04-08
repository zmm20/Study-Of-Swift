//
//  collectionTypes_test.swift
//  hello swift
//
//  Created by 周满满 on 4/7/16.
//  Copyright © 2016 周满满. All rights reserved.
//

import Foundation

func CollectionTypesTest(){
    print("集合测试：")
    var someInts = [Int]()
    print("someInts is of type [Int] with \(someInts.count) items.")
    // 打印 "someInts is of type [Int] with 0 items.”
    someInts.append(3)
    // someInts 现在包含一个 Int 值
    someInts = []
    // someInts 现在是空数组，但是仍然是 [Int] 类型的。
    var threeDoubles = [Double](count: 3, repeatedValue:0.0)
    var anotherThreeDoubles = Array(count: 3, repeatedValue: 2.5)
    // anotherThreeDoubles 被推断为 [Double]，等价于 [2.5, 2.5, 2.5]
    
    var sixDoubles = threeDoubles + anotherThreeDoubles
    // sixDoubles 被推断为 [Double]，等价于 [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
    // threeDoubles 是一种 [Double] 数组，等价于 [0.0, 0.0, 0.0]
    
    var shoppingList = ["Eggs", "Milk"]
    shoppingList.append("Flour")
    shoppingList += ["Baking Powder"]
    // shoppingList 现在有四项了
    shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
    // shoppingList 现在有七项了
    //var shoppingList: [String] = ["Eggs", "Milk"]
    shoppingList[0] = "Six eggs"
    shoppingList[4...6] = ["Bananas", "Apples"]
    // shoppingList 现在有6项
    shoppingList.insert("Maple Syrup", atIndex: 0)
    // shoppingList 现在有7项
    // "Maple Syrup" 现在是这个列表中的第一项
    let mapleSyrup = shoppingList.removeAtIndex(0)
    // 索引值为0的数据项被移除
    // shoppingList 现在只有6项，而且不包括 Maple Syrup
    // mapleSyrup 常量的值等于被移除数据项的值 "Maple Syrup"
    let apples = shoppingList.removeLast()
    // 数组的最后一项被移除了
    // shoppingList 现在只有5项，不包括 cheese
    // apples 常量的值现在等于 "Apples" 字符串”
    for item in shoppingList {
        print(item)
    }
    // Six eggs
    // Milk
    // Flour
    // Baking Powder
    // Bananas
    for (index, value) in shoppingList.enumerate() {
        print("Item \(String(index)): \(value)")
    }
    // Item 1: Six eggs
    // Item 2: Milk
    // Item 3: Flour
    // Item 4: Baking Powder
    // Item 5: Bananas
    
    
    //集合
    var letters = Set<Character>()
    print("letters is of type Set<Character> with \(letters.count) items.")
    // 打印 "letters is of type Set<Character> with 0 items.”
    letters.insert("a")
    // letters 现在含有1个 Character 类型的值
    letters = []
    // letters 现在是一个空的 Set, 但是它依然是 Set<Character> 类型
    
    var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
    // 等效：   var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
    // favoriteGenres 被构造成含有三个初始值的集合
    print("I have \(favoriteGenres.count) favorite music genres.")
    // 打印 "I have 3 favorite music genres."
    if favoriteGenres.isEmpty {
        print("As far as music goes, I'm not picky.")
    } else {
        print("I have particular music preferences.")
    }
    // 打印 "I have particular music preferences."
    favoriteGenres.insert("Jazz")
    // favoriteGenres 现在包含4个元素
    
    if let removedGenre = favoriteGenres.remove("Rock") {
        print("\(removedGenre)? I'm over it.")
    } else {
        print("I never much cared for that.")
    }
    // 打印 "Rock? I'm over it.
    
    for genre in favoriteGenres.sort() {
        print("\(genre)")
    }
    // prints "Classical"
    // prints "Hip hop"
    // prints "Jazz”
    
    let oddDigits: Set = [1, 3, 5, 7, 9]
    let evenDigits: Set = [0, 2, 4, 6, 8]
    let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
    oddDigits.union(evenDigits).sort()
    // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    oddDigits.intersect(evenDigits).sort()
    // []
    oddDigits.subtract(singleDigitPrimeNumbers).sort()
    // [1, 9]
    oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort()
    // [1, 2, 9]
    
    let houseAnimals: Set = ["🐶", "🐱"]
    let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
    let cityAnimals: Set = ["🐦", "🐭"]
    houseAnimals.isSubsetOf(farmAnimals)
    // true
    farmAnimals.isSupersetOf(houseAnimals)
    // true
    farmAnimals.isDisjointWith(cityAnimals)
    // true
    
    // 字典测试
    var namesOfIntegers = [Int: String]()
    //var namesOfIntegers = Dictionary<Int, String>()
    // namesOfIntegers 是一个空的 [Int: String] 字典
    namesOfIntegers[16] = "sixteen"
    // namesOfIntegers 现在包含一个键值对
    namesOfIntegers = [:]
    // namesOfIntegers 又成为了一个 [Int: String] 类型的空字典
    
    var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
    if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB"){
        print("The old value for DUB was \(oldValue).")
    }
    airports["APL"] = "Apple Internation"
    // "Apple Internation" 不是真的 APL 机场, 删除它
    airports["APL"] = nil
    // APL 现在被移除了
    for (airportCode, airportName) in airports {
        print("\(airportCode): \(airportName)")
    }
    // YYZ: Toronto Pearson
    // LHR: London Heathrow
    
    for airportCode in airports.keys {
        print("Airport code: \(airportCode)")
    }
    // Airport code: YYZ
    // Airport code: LHR
    for airportName in airports.values {
        print("Airport name: \(airportName)")
    }
    // Airport name: Toronto Pearson
    // Airport name: London Heathrow
}