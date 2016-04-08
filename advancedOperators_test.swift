//
//  advancedOperators_test.swift
//  hello swift
//
//  Created by 周满满 on 4/3/16.
//  Copyright © 2016 周满满. All rights reserved.
//

import Foundation

private func printBinary(c : String, opt1 : UInt8, value : UInt8){
    print("\(c)0b\(String(opt1, radix : 2)) = 0b\(String(value, radix : 2))")
}
private func printBinary(opt1 : UInt8, c : String, opt2 : UInt8, value : UInt8){
    if c == "<<" || c == ">>"{
        print("0b\(String(opt1, radix : 2)) \(c) \(opt2) = 0b\(String(value, radix : 2))")
    }
    else {
        print("0b\(String(opt1, radix : 2)) \(c) 0b\(String(opt2, radix : 2)) = 0b\(String(value, radix : 2))")
    }
  
}

struct Vector2D {
    var x = 0.0, y = 0.0
}
// 重载运算符
func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}
prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}



func AdvancedOperatorsTest(){
    let initialBits: UInt8 = 0b00001111
    let invertedBits = ~initialBits  // 等于 0b11110000
    printBinary("~", opt1: initialBits, value: invertedBits)
    
    var firstBits: UInt8 = 0b11111100
    var otherBits: UInt8  = 0b00111111
    var outputBits = firstBits & otherBits  // 等于 00111100
    printBinary(firstBits, c : "&", opt2: otherBits, value: outputBits)
    
    firstBits = 0b10110010
    otherBits = 0b01011110
    outputBits = firstBits | otherBits  // 等于 11111110
    printBinary(firstBits, c : "|", opt2: otherBits, value: outputBits)
    
    firstBits = 0b00010100
    otherBits = 0b00000101
    outputBits = firstBits ^ otherBits  // 等于 00010001
    printBinary(firstBits, c : "^", opt2: otherBits, value: outputBits)
    
    firstBits = 4   // 即二进制的00000100
    outputBits = firstBits << 1             // 00001000
    printBinary(firstBits, c : "<<", opt2: 1, value: outputBits)
    outputBits = firstBits >> 2             // 00000001
    printBinary(firstBits, c : ">>", opt2: 2, value: outputBits)
    
    print("重载运算符测试:")
    let vector = Vector2D(x: 3.0, y: 1.0)
    let anotherVector = Vector2D(x: 2.0, y: 4.0)
    let combinedVector = vector + anotherVector
    // combinedVector 是一个新的Vector2D, 值为 (5.0, 5.0)”
    print("combined vector1 and vector2 is x: \(combinedVector.x), y: \(combinedVector.y)")
    
    
}