//
//  ViewController.swift
//  ObjcSerializeStu
//
//  Created by tlc on 2018/3/29.
//  Copyright © 2018年 tlc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /***** ================ *****/
        
        // UserDefaults 支持的数据格式也很多，有：Int，Float，Double，BOOL，Array，Dictionary，甚至 Any 类型。
        UserDefaults.standard.set("https://www.baidu.com", forKey: "baiduUrl")
        if let str = UserDefaults.standard.object(forKey: "baiduUrl") {
            print(str)
            UserDefaults.standard.removeObject(forKey: "baiduUrl")
            
            if UserDefaults.standard.object(forKey: "baiduUrl") == nil {
                print("已删除")
            }
        }
        /** 关于 UserDefaults 教程
        转 http://www.hangge.com/blog/cache/detail_668.html
        */
        
        
         /***** ================ *****/
        let dict = ["key":90, "name":"K*T","array":[1, 3, " 3 ", " 1 23", 1.2]] as [String : Any]
        if PropertyListSerialization.propertyList(dict, isValidFor: PropertyListSerialization.PropertyListFormat.binary) {
            do {
                // 将字典数组转成data
                let data = try PropertyListSerialization.data(fromPropertyList: dict, format: PropertyListSerialization.PropertyListFormat.binary, options: PropertyListSerialization.WriteOptions.init(1))
                print(data)
                
                // 从data将持久化的内容读出来
                let z = try PropertyListSerialization.propertyList(from: data, options: PropertyListSerialization.ReadOptions.init(rawValue: 1), format: nil)
                print(z)
            }catch let error {
                print(error.localizedDescription)
            }
        }
        
        
        /***** ================ *****/
        
        let fileName = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!+"/person"
        
        // 持久化到文件
        let p1 = Person.init(name: "张三", age: 23)
        let result = NSKeyedArchiver.archiveRootObject(p1, toFile: fileName)//持久化到文件
        if result {
            print("success")
        }else{
            print("failed")
        }
        
        // 从文件中读取
        if let p1 = NSKeyedUnarchiver.unarchiveObject(withFile: fileName) as? Person {
            print(p1.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

