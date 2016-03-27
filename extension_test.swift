//
//  extension_test.swift
//  hello swift
//
//  Created by 周满满 on 16/3/26.
//  Copyright © 2016年 周满满. All rights reserved.
//

import Foundation

extension Double {
    var km: Double { return self * 1_000.0 }
    var m : Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

extension Int {
    func repetitions(task: () -> ()) {
        for _ in 0..<self {
            task()
        }
    }
    mutating func square() {
        self = self * self
    }
    subscript(digitIndex: Int) -> Int {
        var tempIndex = digitIndex
        var decimalBase = 1
        while tempIndex > 0 {
            decimalBase *= 10
            tempIndex -= 1
        }
        return (self / decimalBase) % 10
    }
    
    enum Kind {
        case Negative, Zero, Positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}
func printIntegerKinds(numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("- ", separator: "", terminator: "")
        case .Zero:
            print("0 ", separator: "", terminator: "")
        case .Positive:
            print("+ ", separator: "", terminator: "")
        }
    }
    print("")
}

func extensionTest(){
    let oneInch = 25.4.mm
    print("One inch is \(oneInch) meters")
    // 打印输出："One inch is 0.0254 meters"
    let threeFeet = 3.ft
    print("Three feet is \(threeFeet) meters")
    // 打印输出："Three feet is 0.914399970739201 meters”
    
    let aMarathon = 42.km + 195.m
    print("A marathon is \(aMarathon) meters long")
    // 打印输出："A marathon is 42195.0 meters long”
    
    let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                             size: Size(width: 3.0, height: 3.0))
    // centerRect的原点是 (2.5, 2.5)，大小是 (3.0, 3.0)
    print("rectange center position is :x = \(centerRect.origin.x), y = \(centerRect.origin.y), and size is: width = \(centerRect.size.width), height = \(centerRect.size.height)")
    
    3.repetitions({
        print("Hello!")
    })
    // Hello!
    // Hello!
    // Hello!”
    var someInt = 3
    someInt.square()
    print("the square of 3 is \(someInt)")
    
    print("12345 the last eliment is \(12345[0])")
    
    printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
    // prints "+ + - 0 - 0 +"
    
}