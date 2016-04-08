//
//  string_test.swift
//  hello swift
//
//  Created by 周满满 on 4/5/16.
//  Copyright © 2016 周满满. All rights reserved.
//

import Foundation

func stringTest(){
    print("字符串测试 \"Dog!🐶\": ", terminator: "")
    for character in "Dog!🐶".characters {
        print(character, terminator: " ")
    }
    print("")
    
    let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
    let catString = String(catCharacters)
    print(catString)
    // 打印输出："Cat!🐱”
    
    // unicode
    print("\u{24}, \u{2665}, \u{1f496}")
    
    let eAcute: Character = "\u{E9}"                         // é
    let combinedEAcute: Character = "\u{65}\u{301}"          // e 后面加上  ́”
    let enclosedEAcute: Character = "\u{E9}\u{20DD}"
    print("\(eAcute) \(combinedEAcute) \(enclosedEAcute)")
    
    let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
    print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")
    
    var word = "cafe"
    print("the number of characters in \(word) is \(word.characters.count)")
    // 打印输出 "the number of characters in cafe is 4"
    
    word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301
    
    print("the number of characters in \(word) is \(word.characters.count)")
    // 打印输出 "the number of characters in café is 4”
    
    let dogString = "Dog‼🐶"
    for codeUnit in dogString.utf8 {
        print("\(codeUnit) ", terminator: "")
    }
    print("")
    // 68 111 103   226 128 188   240 159 144 182
    
    for codeUnit in dogString.utf16 {
        print("\(codeUnit) ", terminator: "")
    }
    print("")
    // 68 111 103   8252   55357 56374
    
    for scalar in dogString.unicodeScalars {
        print("\(scalar.value) ", terminator: "")
    }
    print("")
    // 68 111 103 8252 128054”
    
    for scalar in dogString.unicodeScalars {
        print("\(scalar) ", terminator: "")
    }
    print("")
    
}