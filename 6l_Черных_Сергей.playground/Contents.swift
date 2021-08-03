//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//3. *Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.

enum Gender {
    case male, female
}

class Human {
    let name: String
    let gender: Gender
    var age: UInt8
    
    init(name: String, gender: Gender, age: UInt8) {
        self.name = name
        self.gender = gender
        self.age = age
    }
}

extension Human: CustomDebugStringConvertible {
    var debugDescription: String {
        "\(name) \(age)"
    }
}

struct Queue<T> {
    private var data: [T] = []
    
    mutating func push(element: T) {
        data.append(element)
    }
    mutating func push(arrayElements: [T]) {
        for value in arrayElements {
            push(element: value)
        }
    }
    mutating func pop() -> T? {
        guard data.count > 0 else { return nil }
        return data.remove(at: 0)
    }
    func filter(pridicate: (T) -> Bool) -> [T] {
        var filterData: [T] = []
        for value in data {
            if pridicate(value) { filterData.append(value) }
        }
        return filterData
    }
    func foreach(predicate: (T) -> Void) -> [T] {
        var newArray: [T] = []
        for value in data {
            predicate(value)
            newArray.append(value)
        }
        return newArray
    }
    subscript(index: Int) -> T? {
        guard index < data.count else { return nil }
        return data[index]
    }
}

extension Queue: CustomDebugStringConvertible {
    var debugDescription: String {
        data.debugDescription
    }
}

var intQueue = Queue<Int>()
intQueue.push(element: 9)
intQueue.push(element: 7)
intQueue.push(arrayElements: Array(1...3))
print(intQueue)

intQueue.pop()
intQueue.pop()
intQueue.pop()
intQueue.pop()
intQueue.pop()
intQueue.pop()

intQueue.push(arrayElements: Array(-10...10))
print(intQueue)
let filterTest = intQueue.filter { $0 % 2 == 0 && $0 > 0 }
print(filterTest)


let human1 = Human(name: "Nickolas", gender: .male, age: 41)
let human2 = Human(name: "Eva", gender: .female, age: 34)
let human3 = Human(name: "Benjamin", gender: .male, age: 20)
let human4 = Human(name: "Sara", gender: .female, age: 23)
var humans = Queue<Human>()
humans.push(element: human1)
humans.push(arrayElements: [human2, human3, human4])
print(humans)

let filterHumans = humans.filter {$0.age < 30}
print(filterHumans)
let filterHumans2 = humans.filter { $0.gender == .male }
print(filterHumans2)
let newArrayHumans = humans.foreach { $0.age += 1  }
print(newArrayHumans)

humans[1]

humans.pop()
humans.pop()
humans.pop()
humans.pop()
humans.pop()
