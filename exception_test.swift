//
//  exception_test.swift
//  hello swift
//
//  Created by 周满满 on 16/3/19.
//  Copyright © 2016年 周满满. All rights reserved.
//

import Foundation

func exceptionTest() throws {//throws 不可以丢失，因为函数中包含try
    print("exception test begin--------------------------------")
    let vendingMachine = VendingMachine()
    vendingMachine.coinsDeposited = 8
    do {
        try buyFavoriteSnack("Alice", vendingMachine: vendingMachine)
        print("continue1")
    } catch VendingMachineError.InvalidSelection {
        print("Invalid Selection.")
    } catch VendingMachineError.OutOfStock {
        print("Out of Stock.")
    } catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
        print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
    }
    // prints "Insufficient funds. Please insert an additional 2 coins.”
    print("continue2")
    print("exception test end--------------------------------")
}

enum VendingMachineError: ErrorType {
    case InvalidSelection    //选择无效
    case InsufficientFunds(coinsNeeded: Int)    //金额不足
    case OutOfStock            //缺货
}

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    
    func vend(itemNamed name: String) throws {
        guard var item = inventory[name] else {
            throw VendingMachineError.InvalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.OutOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        item.count -= 1
        inventory[name] = item
        dispenseSnack(name)
    }
}


let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws{
    defer{print("defer test 1")}
    defer{print("defer test 2")}
    
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)

    defer{print("defer test 3")}
}