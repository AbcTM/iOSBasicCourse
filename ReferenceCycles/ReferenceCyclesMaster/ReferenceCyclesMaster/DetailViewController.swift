//
//  DetailViewController.swift
//  ReferenceCyclesMaster
//
//  Created by tlc on 2018/4/9.
//  Copyright © 2018年 tlc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var msgLabel: UILabel!
    
    var p1: Person!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        p1 = Person.init(name: "王梅梅", age: 0)
        
        // 此处注意 DetailViewController 持有p1, p1 的 closure 捕获 self, 形成循环引用，导致p1,DetailViewController，内存释放不了
//        p1.closure = { [weak self] (name, age)in // 解决办法 unowned 无主引用， 或者 weak self;怎么选择呢？
//            // 关于两者使用的选择，Apple 给我们的建议是如果能够确定在访问时不会已被释放的话，尽量使用 unowned ，如果存在被释放的可能，那就选择用 weak 。
//            guard let strongSelf = self else {
//                return
//            }
//            // 这里不只是 方法或者属性
//            let content = strongSelf.closure
//            strongSelf.updateMsgContent(content)
        


            /**
             unowned
             Fatal error: Attempted to read an unowned reference but the object was already deallocated2018-04-09 17:10:19.300144+0800 ReferenceCyclesMaster[48649:5066549] Fatal error: Attempted to read an unowned reference but the object was already
             */
//            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 4.0, execute: {
//                DispatchQueue.main.async { [unowned strongSelf] in
//
//                    strongSelf.updateMsgContent()
//                }
//            })
//        }
        
        p1.personAgeChange { [weak self] in
            self?.updateMsgContent()
            
        }
        self.updateMsgContent()
    }
    
    deinit {
        print("DetailViewController 销毁")
        p1 = nil
    }
    
    // MARK: - Action Methods
    func updateMsgContent() {
//        let content = p1.closure()
        let content = "\(p1.name)-\(p1.age)"
        self.msgLabel.text = content
    }
    
    @IBAction func decreaseAction(_ sender: Any) {
        p1.age -= 1
        
        self.updateMsgContent()
    }
    
    @IBAction func increaseAction(_ sender: Any) {
        p1.age += 1
        
        self.updateMsgContent()
    }
    
    // MARK: -
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
