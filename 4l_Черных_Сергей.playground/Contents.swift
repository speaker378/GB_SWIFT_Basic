//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//2. Описать пару его наследников TrunkCar и SportCar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет TrunkCar, а какие – SportCar. Добавить эти действия в перечисление.
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

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

enum EngineSound: String {
    case sport = "Vrooom"
    case trunk = "Tyr-Tyr"
}

class Car {
    let carBrand: String
    let yearOfIssue: UInt16
    let trankVolume: UInt32
    private (set) var engineStatus = EngineState.stop
    private var windowsStatus = WindowsState.close
    private var trankContents: Dictionary<String, UInt32> = [:]
    
    var occupiedTrunkSpace: UInt32 {
        var total: UInt32 = 0
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
    
    init(carBrand: String, yearOfIssue: UInt16, trankVolume: UInt32) {
        self.carBrand = carBrand
        self.yearOfIssue = yearOfIssue
        self.trankVolume = trankVolume
    }
    
    func engine(_ action: EngineState) {
        if action == .start {
            self.engineStatus = .start
            print(engineStatus.rawValue)
        } else {
            self.engineStatus = .stop
            print(engineStatus.rawValue)
        }
    }
    
    func windows(_ action: WindowsState) {
        if action == .open {
            self.windowsStatus = .open
            print(windowsStatus.rawValue)
        } else {
            self.windowsStatus = .close
            print(windowsStatus.rawValue)
        }
    }
    
    func putInTheTrunk(_ load: [String : UInt32]) {
        // Проверим сколько пытаемся добавить в багажник
        var sumLoad = occupiedTrunkSpace
        for i in load.values {
            sumLoad += i
        }
        guard sumLoad < trankVolume else {
            print("Так много в груза не уместить!")
            return
        }
        for (key, value) in load {
            if trankContents[key] == nil {
                trankContents[key] = value
            } else {
                trankContents[key] = value + trankContents[key]!
            }
        }
    }
    
    func printTrunkContent(detail: Bool = false) {
        print("Содержимое багажника: ", terminator: "")
        if detail {
            for (key, value) in trankContents {
                print("\(key) - \(value)", terminator: "; ")
            }
        } else {
            for i in trankContents.keys {
                print(i, terminator: "; ")
            }
        }
        print()
    }
    
    func pressingTheGasPedal(){
    }
}

class SportCar: Car {
    let acceleration: Double
    
    init(carBrand: String, yearOfIssue: UInt16, trankVolume: UInt32, acceleration: Double) {
        self.acceleration = acceleration
        super.init(carBrand: carBrand, yearOfIssue: yearOfIssue, trankVolume: trankVolume)
    }
    
    override func pressingTheGasPedal() {
        guard engineStatus == .start else {
            return
        }
        print(EngineSound.sport.rawValue)
    }
}

class TrunkCar: Car {
    let numberOfTrailers: UInt8
    
    init(carBrand: String, yearOfIssue: UInt16, trankVolume: UInt32, numberOfTrailers: UInt8) {
        self.numberOfTrailers = numberOfTrailers
        super.init(carBrand: carBrand, yearOfIssue: yearOfIssue, trankVolume: trankVolume)
    }
    
    override func pressingTheGasPedal() {
        guard engineStatus == .start else {
            return
        }
        print(EngineSound.trunk.rawValue)
    }
}

let sportCar1 = SportCar(carBrand: "Lamborghini Aventador", yearOfIssue: 2020, trankVolume: 40, acceleration: 2.9)
let sportCar2 = SportCar(carBrand: "Maserati Granturismo", yearOfIssue: 2019, trankVolume: 100, acceleration: 4.7)
let trunkCar1 = TrunkCar(carBrand: "Volvo FH", yearOfIssue: 2021, trankVolume: 100_000, numberOfTrailers: 1)
let trunkCar2 = TrunkCar(carBrand: "Scania S500", yearOfIssue: 2018, trankVolume: 160_000, numberOfTrailers: 2)

sportCar1.windows(.open)
sportCar1.windows(.close)
sportCar1.engine(.start)
sportCar1.pressingTheGasPedal()

trunkCar1.putInTheTrunk(["яблоки" : 2300, "бумага" : 12_000])
trunkCar1.putInTheTrunk(["камни" : 490_000])
trunkCar1.putInTheTrunk(["яблоки" : 12_000, "бумага" : 11_200])
trunkCar1.putInTheTrunk(["краска" : 34_000])
trunkCar1.printTrunkContent()
trunkCar1.printTrunkContent(detail: true)

trunkCar2.windows(.open)
trunkCar2.pressingTheGasPedal()
trunkCar2.engine(.start)
trunkCar2.pressingTheGasPedal()

print("Еще свободно \(trunkCar1.occupiedTrunkSpace) л")
print(trunkCar1.trankFreeSpace)
print("\(sportCar1.carBrand) разгон до 100 за \(sportCar1.acceleration) сек.")
print("\(trunkCar2.carBrand) вместимость груза \(trunkCar2.trankVolume) л")
