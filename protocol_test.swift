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

// 协议作为类型
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

//下面的例子是两个基于骰子游戏的协议：
protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll:Int)
    func gameDidEnd(game: DiceGame)
}
class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = [Int](count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self,didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}
class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}


//在扩展中添加协议成员
protocol TextRepresentable {
    var textualDescription: String { get }
}
extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}


//
protocol HasArea {
    var area: Double { get }
}
class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

// “协议可以含有可选成员，其遵循者可以选择是否实现这些成员”
@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}
@objc class Counter : NSObject{
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}
@objc class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}
@objc class TowardsZeroSource: NSObject, CounterDataSource {
    func incrementForCount(count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}




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
    
    let d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
    for _ in 1...5 {
        print("Random dice roll is \(d6.roll())")
    }
    //输出结果
    //Random dice roll is 3
    //Random dice roll is 5
    //Random dice roll is 4
    //Random dice roll is 5
    //Random dice roll is 4
    
    //测试游戏
    print("test SnakesAndLadders")
    let tracker = DiceGameTracker()
    let game = SnakesAndLadders()
    game.delegate = tracker
    game.play()
    // 开始一个新的Snakes and Ladders的游戏
    // 游戏使用 6 面的骰子
    // 翻转得到 3
    // 翻转得到 5
    // 翻转得到 4
    // 翻转得到 5
    // 游戏进行了 4 轮

    print("通过扩展使得Dice类型遵循了一个新的协议--test")
    let d12 = Dice(sides: 12,generator: LinearCongruentialGenerator())
    print(d12.textualDescription)
    // 输出 "A 12-sided dice"
    
    
    print("测试协议类型的检查")
    let objects: [AnyObject] = [
        Circle(radius: 2.0),
        Country(area: 243_610),
        Animal(legs: 4)
    ]
    for object in objects {
        if let objectWithArea = object as? HasArea {
            print("Area is \(objectWithArea.area)")
        } else {
            print("Something that doesn't have an area")
        }
    }
    // Area is 12.5663708
    // Area is 243610.0
    // Something that doesn't have an area”
    
    print("协议中的可选成员测试1")
    let counter = Counter()
    counter.dataSource = ThreeSource()
    for _ in 1...4 {
        counter.increment()
        print(counter.count)
    }
    // 3
    // 6
    // 9
    // 12
    print("协议中的可选成员测试2")
    counter.count = -4
    counter.dataSource = TowardsZeroSource()
    for _ in 1...5 {
        counter.increment()
        print(counter.count)
    }
    // -3
    // -2
    // -1
    // 0
    // 0

}
