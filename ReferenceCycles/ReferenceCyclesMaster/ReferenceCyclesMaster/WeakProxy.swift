//
//  WeakProxy.swift
//  ReferenceCyclesMaster
//
//  Created by tlc on 2018/5/2.
//  Copyright © 2018年 tlc. All rights reserved.
//

import UIKit

class WeakProxy: NSObject {

    weak var target: NSObjectProtocol?
    
    init(target: NSObjectProtocol) {
        self.target = target
        super.init()
    }
    
    override func responds(to aSelector: Selector!) -> Bool {
        return (target?.responds(to: aSelector) ?? false) || super.responds(to: aSelector)
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return target
    }
}
