//: Playground - noun: a place where people can play

import UIKit

print("内容来自：http://python.ctolib.com/article/wiki/73567")

/*
// 一、 Key path

class User {
    var name = ""
    var age = 0
}

let user1 = User()
user1.name = "zhangxiang"
user1.age = 29

let pName = user1[keyPath: \User.name]
print(pName)

user1[keyPath: \User.name] = "kkkkk"
print(user1.name)

//let observer: NSKeyValueObservation = observeValue


// 二、 a&a type
protocol MyProtocol { }

class View { }
class ViewSubClass: View & MyProtocol{ }
class MyClass {
    var delegate: (View & MyProtocol)?
}

let myClass = MyClass()
myClass.delegate = ViewSubClass()
//myClass.delegate = View() error
/**
 myClass.delegate = View()
 ^~~~~~
 as! (View & MyProtocol)
 */

protocol Shakeable {
    func shake()
}

extension UIButton: Shakeable {
    func shake() {
        /* ... */
    }
}

extension UISlider: Shakeable {
    func shake() {
        /* ... */
    }
}

func shakeEm(controls: [UIControl & Shakeable]) {
    for control in controls where control.isEnabled {
        control.shake()
    }
}



// 三、 subscript support generics
struct GenericDictionary<Key: Hashable, Value> {
    private var data: [Key: Value]
    
    init(data: [Key: Value]) {
        self.data = data
    }
    
    subscript<T>(key: Key) -> T? {
        return data[key] as? T
    }
}

// 补充下标支持数组传入
extension GenericDictionary {
    subscript<Keys: Sequence>(keys: Keys) -> [Value] where Keys.Iterator.Element == Key {
        var values: [Value] = []
        for key in keys {
            if let value = data[key] {
                values.append(value)
            }
        }
        
        return values
    }
}

// Dictionary type: [String: Any]
let earthData = GenericDictionary(data: ["name": "Earth", "population": 7500000000, "moons": 1])

// Automatic conversion type, no need to write "as? String"
let name: String? = earthData["name"]
print(name ?? "")

// Automatic conversion type, no need to write "as? Int"
let population: Int? = earthData["population"]
print(population ?? "")


// Array index
let nameAndMoons = earthData[["moons", "name"]]        // [1, "Earth"]
// Set index
let nameAndMoons2 = earthData[Set(["moons", "name"])]  // [1, "Earth"]



// 四、Codable serialization

struct Language: Codable {
    var name: String
    var version: Int
}

let swift = Language(name: "Swift", version: 4)

// Encoded object
let encodedData = try JSONEncoder().encode(swift)

// Get a String from the encoded object
let jsonString = String(data: encodedData, encoding: .utf8)
print(jsonString!)


let decodedData = try JSONDecoder().decode(Language.self, from: encodedData)
print(decodedData.name, decodedData.version)
*/

// 五、Subtring

extension String {
    // Choosing a string based on start position and length
    func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
    
    subscript(Is: Range<Int>) -> String {
        return subString(start: Is.lowerBound, length: Is.count)
    }
}

let str = "abcdefghijk"
print(str.prefix(5))
print(str.suffix(5))
print(str.dropFirst())
print(str.dropFirst(1))
print(str.dropLast())
print(str.dropLast(4))
print(str[0..<3])

// 六、Cancel the swap method

//var a = 1
//var b = 2
//swap(&a, &b)
//print(a, b)
//
//// 推荐使用元组
//
//var a = 1
//var b = 2
//(b, a) = (a, b)
//print(a, b)
//
//var a = 1
//var b = 2
//var c = 3
//(a, b, c) = (b, c, a)
//print(a, b, c)

// 添加数组swapAt方法
var fruits = ["apple", "pear", "grape", "banana"]
// Exchanging element positions (exchanging the 2nd and 3rd element positions)
fruits.swapAt(1, 2)
print(fruits)

// 七、减少隐式 @objc 自动推断

/**
 1.过去的情况（Swift3）
 1）在项目中如果想把 Swift 写的 API 暴露给 Objective-C 调用，需要增加 @objc。在 Swift 3 中，编译器会在很多地方为我们隐式的加上 @objc。
 class MyClass: NSObject {
 func print() { } // 包含隐式的 @objc
 func show() { } // 包含隐式的 @objc
 }
 2）比如当一个类继承于 NSObject，那么这个类的所有方法都会被隐式的加上 @objc。
 3）但这样做很多并不需要暴露给 Objective-C 也被加上了 @objc。而大量 @objc 会导致二进制文件大小的增加。
 
 2.现在的情况（Swift4）
 1）在 Swift 4 中隐式 @objc 自动推断只会发生在下面这种必须要使用 @objc 的情况：
 
 覆盖父类的 Objective-C 方法
 符合一个 Objective-C 的协议
 
 2）大多数地方必须手工显示地加上 @objc。
 
 class MyClass: NSObject {
 @objc func print() { } //显示的加上 @objc
 @objc func show() { } //显示的加上 @objc
 }
 
 3）如果在类前加上 @objcMembers，那么它、它的子类、扩展里的方法都会隐式的加上 @objc。
 @objcMembers
 class MyClass: NSObject {
 func print() { } //包含隐式的 @objc
 func show() { } //包含隐式的 @objc
 }
 
 extension MyClass {
 func baz() { } //包含隐式的 @objc
 }
 
 4）如果在扩展（extension）前加上 @objc，那么该扩展里的方法都会隐式的加上 @objc。
 
 class SwiftClass { }
 
 @objc extension SwiftClass {
 func foo() { } //包含隐式的 @objc
 func bar() { } //包含隐式的 @objc
 }
 
 5）如果在扩展（extension）前加上 @nonobjc，那么该扩展里的方法都不会隐式的加上 @objc。
 
 @objcMembers
 class MyClass : NSObject {
 func wibble() { } //包含隐式的 @objc
 }
 
 @nonobjc extension MyClass {
 func wobble() { } //不会包含隐式的 @objc
 }
 */
