//
//  Person.swift
//  ReferenceCyclesMaster
//
//  Created by tlc on 2018/4/9.
//  Copyright © 2018年 tlc. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var age: Int
    
    typealias PersonAgeChangedClosure = ()->String
    lazy var closure: PersonAgeChangedClosure = { [unowned self] () -> String in
//        if let strongSelf = self {
            return "姓名：\(self.name), 年龄：\(self.age)"
//        }
//        return ""
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
        
        print("Person.name: \(name), age:\(age) init")
    }
    
    deinit {
        print("Person.name: \(name), age:\(age) deinit")
    }
}
