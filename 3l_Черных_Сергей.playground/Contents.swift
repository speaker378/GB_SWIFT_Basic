// 1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
// 2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
// 3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
// 4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
// 5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
// 6. Вывести значения свойств экземпляров в консоль.

enum EngineState: String {
    case start = "Двигатель запущен."
    case stop = "Двигатель заглушен."
}

enum WindowsState: String {
    case open = "Окна открыты."
    case close = "Окна закрыты."
}

enum TrankFreeSpace {
    case full
    case empty
    case free
}


struct SportCar {
    let carBrand: String
    let yearOfIssue: Double
    let trankVolume: Double
    var engineStatus = EngineState.stop
    var windowsStatus = WindowsState.close
    var trankContents: Dictionary<String, Double> = [:] {
        didSet {
            print("Содержимое багажника: ", terminator: "")
            for i in trankContents.keys {
                print(i, terminator: "; ")
            }
            print("")
        }
    }
    
    var occupiedTrunkSpace: Double {
        var total: Double = 0
        for (_, j) in trankContents {
            total += j
        }
        return total
    }
    
    var trankFreeSpace: TrankFreeSpace {
        if occupiedTrunkSpace == 0 {
            return .empty
        } else if occupiedTrunkSpace < trankVolume {
            return .free
        } else {
            return .full
        }
    }

    
    mutating func engine(_ action: EngineState) {
        if action == .start {
            self.engineStatus = .start
            print(engineStatus.rawValue)
        } else {
            self.engineStatus = .stop
            print(engineStatus.rawValue)
        }
        
    }
    
    mutating func windows(_ action: WindowsState) {
        if action == .open {
            self.windowsStatus = .open
            print(windowsStatus.rawValue)
        } else {
            self.windowsStatus = .close
            print(windowsStatus.rawValue)
        }
    }
    
    mutating func putInTheTrunk(_ load: [String : Double]) {
        // Проверим сколько пытаемся добавить в багажник
        var sumLoad = occupiedTrunkSpace
        for i in load.values {
            sumLoad += i
        }
        if sumLoad > trankVolume {
            print("Так много в богажник не уместить!")
        } else {
            for (key, value) in load {
                if trankContents[key] == nil {
                    trankContents[key] = value
                } else {
                    trankContents[key] = value + trankContents[key]!
                }
            }
        }
    }

}


var car1 = SportCar(carBrand: "Volvo", yearOfIssue: 2020, trankVolume: 200)
var car2 = SportCar(carBrand: "Jaguar", yearOfIssue: 2015, trankVolume: 15)

car1.engine(.start)
car1.engine(.stop)
car2.windows(.open)
car2.windows(.close)
car1.putInTheTrunk(["apples" : 23, "paper" : 12])
car1.trankContents
car1.putInTheTrunk(["stones" : 490])
car1.trankContents
print(car1.occupiedTrunkSpace)
car1.putInTheTrunk(["apples" : 23, "paper" : 12])
car1.trankContents
print(car1.trankFreeSpace)
car2.trankContents
print(car2.trankFreeSpace)

