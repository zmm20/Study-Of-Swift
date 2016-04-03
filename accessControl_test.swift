//
//  accessControl_test.swift
//  hello swift
//
//  Created by 周满满 on 4/2/16.
//  Copyright © 2016 周满满. All rights reserved.
//

import Foundation

public class SomePublicClass {          // 显式的 public 类
    public var somePublicProperty = 0    // 显式的 public 类成员
    var someInternalProperty = 0         // 隐式的 internal 类成员
    private func somePrivateMethod() {}  // 显式的 private 类成员
}

class SomeInternalClass {               // 隐式的 internal 类
    var someInternalProperty = 0         // 隐式的 internal 类成员
    private func somePrivateMethod() {}  // 显式的 private 类成员
}

private class SomePrivateClass {        // 显式的 private 类
    var somePrivateProperty = 0          // 隐式的 private 类成员
    func somePrivateMethod() {}          // 隐式的 private 类成员
}

struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

func AccessControlTest(){
    var stringToEdit = TrackedString()
    stringToEdit.value = "This string will be tracked."
    stringToEdit.value += " This edit will increment numberOfEdits."
    stringToEdit.value += " So will this one."
    print("The number of edits is \(stringToEdit.numberOfEdits)")
    // prints "The number of edits is 3”
    
    stringToEdit.numberOfEdits = 0 // 可见该成员变量在本源文件中是可以访问的
}



