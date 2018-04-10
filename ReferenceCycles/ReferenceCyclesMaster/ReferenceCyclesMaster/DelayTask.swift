//
//  DelayTask.swift
//  ReferenceCyclesMaster
//
//  Created by tlc on 2018/4/9.
//  Copyright © 2018年 tlc. All rights reserved.
//

import Foundation


//typealias Task = (_ cancel : Bool) -> ()
//
//func delay(time: TimeInterval, task: @escaping ()-> Void) -> Task? {
//
//    func dispatch_later(block:()->()) {
//        DispatchQueue.main.af
//        dispatch_after(
//            dispatch_time(
//                DISPATCH_TIME_NOW,
//                Int64(time * Double(NSEC_PER_SEC))),
//            dispatch_get_main_queue(),
//            block)
//    }
//
//    var closure: (()-> Void)? = task
//    var result: Task?
//
//    let delayedClosure: Task = {
//        cancel in
//        if let internalClosure = closure {
//            if (cancel == false) {
//                DispatchQueue.main.async {
//                    internalClosure
//                }
//            }
//        }
//        closure = nil
//        result = nil
//    }
//
//    result = delayedClosure
//
//    dispatch_later {
//        if let delayedClosure = result {
//            delayedClosure(false)
//        }
//    }
//
//    return result;
//}
//
//func cancel(task:Task?) {
//    task?(true)
//}
