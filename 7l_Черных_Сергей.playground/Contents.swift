//1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
//2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

import Foundation

class TextFile {
    let namePattern = #"^[\w,\s-]+\.[A-Za-z]{3}$"#
    private (set) var name: String
    private var accessPermissions: Bool
    
    init?(name: String, accessPermissions: Bool)  {
        guard name.range(of: namePattern, options: .regularExpression) != nil else {
            return nil
        }
        self.name = name
        self.accessPermissions = accessPermissions
    }
    
    func rename(_ newName: String) -> String? {
        guard accessPermissions else { return nil }
        guard newName.range(of: namePattern, options: .regularExpression) != nil else {
            return nil
        }
        self.name = newName
        return name
    }
}

let myTextFile = TextFile(name: "Notes.txt", accessPermissions: true)
if let newName = myTextFile?.rename("List.doc") {
    print("Имя файла успешно изменено на " + newName)
}
if let newName = myTextFile?.rename("+List/.doc") {
    print("Имя файла успешно изменено на " + newName)
}


enum CoffeeType {
    case espresso
    case cappuccino
}

enum CoffeeMachineError: Error {
    case notEnoughCoffe
    case notEnoughMilk
    case notEnoughWater
    case overflowCoffee
    case overflowMilk
    case overflowWater
}

struct CoffeeIngredients {
    let type: CoffeeType
    var coffee: UInt {
        switch type {
        case .cappuccino:
            return 8
        case .espresso:
            return 10
        }
    }
    var water: UInt {
        switch type {
        case .cappuccino:
            return 40
        case .espresso:
            return 180
        }
    }
    var milk: UInt {
        switch type {
        case .cappuccino:
            return 140
        case .espresso:
            return 0
        }
    }
}

struct Coffee {
    let name: CoffeeType
}

class CoffeeMachine {
    private var coffee: UInt = 0
    private var milk: UInt = 0
    private var water: UInt = 0
    
    func fillCoffee(_ value: UInt) throws {
        guard coffee + value <= 80 else { throw CoffeeMachineError.overflowCoffee }
        coffee += value
    }
    func fillMilk(_ value: UInt) throws {
        guard milk + value <= 280 else { throw CoffeeMachineError.overflowCoffee }
        milk += value
    }
    func fillWater(_ value: UInt) throws {
        guard water + value <= 500 else { throw CoffeeMachineError.overflowWater }
        water += value
    }
    
    func makeCoffee(type: CoffeeType) throws -> Coffee {
        let coffeeRecipe = CoffeeIngredients(type: type)
        
        guard coffee > coffeeRecipe.coffee else { throw CoffeeMachineError.notEnoughCoffe }
        coffee - coffeeRecipe.coffee
        guard milk > coffeeRecipe.milk else { throw CoffeeMachineError.notEnoughMilk }
        milk - coffeeRecipe.milk
        guard water > coffeeRecipe.water else { throw CoffeeMachineError.notEnoughWater }
        water - coffeeRecipe.water
        
        switch type {
        case .cappuccino:
            return Coffee(name: .cappuccino)
        case .espresso:
            return Coffee(name: .espresso)
        }
    }
}

let homeCoffeeMashine = CoffeeMachine()

do {
    try homeCoffeeMashine.fillCoffee(80)
} catch CoffeeMachineError.overflowCoffee {
    print("Так много кофе не поместится в отсек!")
}
do {
    try homeCoffeeMashine.fillMilk(180)
} catch CoffeeMachineError.overflowMilk {
    print("Так много молока не поместится в отсек!")
}
do {
    try homeCoffeeMashine.fillWater(400)
} catch CoffeeMachineError.overflowWater {
    print("Так много воды не поместится в отсек!")
}

do {
    _ = try homeCoffeeMashine.makeCoffee(type: .cappuccino)
    print("Ваш кофе готов!")
} catch CoffeeMachineError.notEnoughCoffe {
    print("Недостаточно кофе!")
} catch CoffeeMachineError.notEnoughMilk {
    print("Недостаточно молока!")
} catch CoffeeMachineError.notEnoughWater {
    print("Недостаточно воды!")
}

