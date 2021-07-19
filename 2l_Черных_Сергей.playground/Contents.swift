import Foundation

// 1. Написать функцию, которая определяет, четное число или нет.

func even(_ num: Int) -> Bool {
    if num % 2 == 0 {
        return true
    } else {
        return false
    }
}


for num in stride(from: 1, to: 11, by: 3) {
    print(even(num) ? "Число \(num) - четное." : "Число \(num) - не четное.")
}

print("\n")

// 2. Написать функцию, которая определяет, делится ли число без остатка на 3.

func divisibilityOnThree(_ num: Int) -> Bool {
    if num % 3 == 0 {
        return true
    } else {
        return false
    }
}


for num in 8...13 {
    print(divisibilityOnThree(num) ? "Число \(num) кратно числу 3." : "Число \(num) не кратно числу 3.")
}

print("\n")

//Более универсальная функция для определения делится ли одно число на другое без остатка.
 
func divisibility(dividend: Int, divider: Int) -> Bool {
    if dividend % divider == 0 {
        return true
    } else {
        return false
    }
}


for dividend in 6...9 {
    for divider in 2...3 {
        print(divisibility(dividend: dividend, divider:divider) ? "Число \(dividend) кратно числу \(divider)." : "Число \(dividend) не кратно числу \(divider).")
    }
}

print("\n")


// 3. Создать возрастающий массив из 100 чисел.

var newArray = [Int](1...100)


// 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

for i in newArray {
    if even(i) || !divisibilityOnThree(i) { // если без функций из заданий 1 и 2 то -> "if i % 2 == 0 || i % 3 != 0"
        newArray.remove(at: newArray.firstIndex(of: i)!)
    }
}

print(newArray)
print("\n")


// 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.

func fib(array: inout [Int], _ n: Int) {
    var a = 0 // первое число последовательности
    var b = 1 // второе число последовательности

    for _ in 0...n {
        (a, b) = (b, a + b)
    }
    
    if !array.contains(a) { // проверка наличия числа в массиве, например массив был передан не пустым
        array.append(a)
    }
}

var testArray: [Int] = []

for i in 1...50 {
    fib(array: &testArray, i)
}


print("Последовательность Фибоначчи из \(testArray.count) элементов: ")

testArray.forEach { i in
    print(i)
}
print("\n")


// 6. * Заполнить массив элементов различными простыми числами.

func eratosthenes(_ n: Int) -> [Int] {
    var sieve = Array(2...n)

    for i in sieve where i != 0 {
        for j in stride(from: 2 * i, to: n + 1, by: i) {
            sieve[j - 2] = 0
        }
    }
    var set = Set(sieve) // удаляем повторяющиеся нули
    set.remove(0) // удаляем оставшийся ноль
    return Array(set).sorted()
}

print(eratosthenes(100))

