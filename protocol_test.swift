//
//  protocol_test.swift
//  hello swift
//
//  Created by 周满满 on 3/29/16.
//  Copyright © 2016 周满满. All rights reserved.
//

import Foundation

protocol FullyNamed {
    var fullName: String { get }
}
struct Person: FullyNamed{
    var fullName: String
}

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}


protocol RandomNumberGenerator {
    func random() -> Double
}
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}


protocol Togglable {
    mutating func toggle()
}
enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}

// 对构造器的协议
protocol SomeProtocol {
    init(someParameter: Int)
}
class SomeClass: SomeProtocol {
    required init(someParameter: Int) {
        //构造器实现
    }
}
class SomeSuperClass {
    init(someParameter: Int) {
        // 构造器的实现
    }
}
class SomeSubClass: SomeSuperClass, SomeProtocol {
    // 因为遵循协议，需要加上"required"; 因为继承自父类，需要加上"override"
    required override init(someParameter: Int) {
        super.init(someParameter : someParameter)
        // 构造器实现
    }
}

// 协议类型，待续
    

// test
func protocol_test() {
    let john = Person(fullName: "John Appleseed")
    print("full name1 is:" + john.fullName)
    //john.fullName 为 "John Appleseed”
    
    let ncc1701 = Starship(name: "Enterprise",prefix: "USS")
    print("full name2 is: " + ncc1701.fullName)
    // ncc1701.fullName 是 "USS Enterprise”
    
    let generator = LinearCongruentialGenerator()
    print("Here's a random number: \(generator.random())")
    // 输出 : "Here's a random number: 0.37464991998171"
    print("And another one: \(generator.random())")
    // 输出 : "And another one: 0.729023776863283”

    
    var lightSwitch = OnOffSwitch.Off
    lightSwitch.toggle()
    //lightSwitch 现在的值为 .On”

}
