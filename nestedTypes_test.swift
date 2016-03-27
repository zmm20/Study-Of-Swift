//
//  nestedTypes_test.swift
//  hello swift
//
//  Created by 周满满 on 16/3/19.
//  Copyright © 2016年 周满满. All rights reserved.
//

import Foundation

struct BlackjackCard {
    // 嵌套定义枚举型Suit
    enum Suit: Character {
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    
    // 嵌套定义枚举型Rank
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard 的属性和方法
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

func nestedTypeTest(){
    let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
    print("theAceOfSpades: \(theAceOfSpades.description)")
    // 打印出 "theAceOfSpades: suit is ♠, value is 1 or 11”
    
    let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue
    print("Hearts rawValue is " + String(heartsSymbol))
    // 红心的符号 为 "♡”
}