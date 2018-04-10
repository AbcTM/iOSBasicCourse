//
//  Person.swift
//  ObjcSerializeStu
//
//  Created by tlc on 2018/3/29.
//  Copyright © 2018年 tlc. All rights reserved.
//

import UIKit

// 父类必须是NSObject, 否则报 Unrecognized selector -[xxx.Person replacementObjectForKeyedArchiver]
// 必须实现NSCoding协议
class Person: NSObject, NSCoding {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.age = aDecoder.decodeInteger(forKey: "age")
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.age, forKey: "age")
    }
    
    override var description: String {
        return "name: \(self.name), age: \(self.age)"
    }
    
    override var debugDescription: String {
        return description
    }
}
/**
 https://stackoverflow.com/questions/25805599/got-unrecognized-selector-replacementobjectforkeyedarchiver-crash-when-impleme
 
 */
