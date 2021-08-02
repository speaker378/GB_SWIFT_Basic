import UIKit

//1. Решить квадратное уравнение ax²+bx+c=0

let a: Float = 5 // старший коэффициент
let b: Float = 15 // средний коэффициент
let c: Float = 10 // свободный член

let d = b * b - 4 * a * c // дискриминант
var x1, x2: Float // корни уравнения

if d > 0 {
    x1 = (-b+sqrt(d))/(2*a)
    x2 = (-b-sqrt(d))/(2*a)
    print("Корней два: x1 = \(x1), x2 = \(x2)")
} else if d == 0{
    x1 = -b/(2*a)
    print("Один корень: x = \(x1)")
} else if d < 0{
    print("Корней на множестве действительных чисел нет")
}

//2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

let aSide: Float = 3 // первый катет
let bSide: Float = 4 // второй катет

let cSide: Float = sqrt(aSide * aSide + bSide * bSide) // гипотенуза
let area: Float = aSide * bSide / 2 // площадь треугольника
let perimeter: Float = aSide + bSide + cSide // периметр треугольника
print("Площадь = \(area)(ед²), периметр = \(perimeter), гипотенуза = \(cSide)")

//3. Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.

let startDeposit: Float = 1_000_000.25 // сумма вклада
let interestRate: Float = 5 // фиксированая ставка % годовых
let placementPeriodInMonths: UInt = 60 // период вклада в месяцах
let interestCapitalization = false // Капитализация процентов на счете по вкладу
let frequencyOfPayments: UInt = 1 // периодичность выплат в месяцах учитывается если есть капитализация процентов

var finalDeposit = startDeposit

if interestCapitalization{
    var pays = Float(placementPeriodInMonths) / Float(frequencyOfPayments) // всего выплат за срок
    
    while pays != 0 {
        let replenishment = finalDeposit * interestRate / 12 * Float(frequencyOfPayments) / 100
        //print("Начислено процентов \(replenishment)")
        finalDeposit += round(100*replenishment)/100
        pays -= 1
    }
} else {
    let accruedInterest = startDeposit * interestRate * Float(placementPeriodInMonths) / 12 / 100
    finalDeposit = accruedInterest + Float(startDeposit)
}

print("Сумма вклада через \(placementPeriodInMonths/12) лет составит - \(finalDeposit)")

