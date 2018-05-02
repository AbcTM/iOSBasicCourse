//
//  LanguageManager.swift
//  LocalizedString
//
//  Created by tlc on 2018/5/2.
//  Copyright © 2018年 tlc. All rights reserved.
//

import Foundation

enum LanguageType: String {
    case en = "en"
    case zhHans = "zh-Hans"
    case zhHant = "zh-Hant"
}

let LANGUAGE_SET = "userlanguage"//AppleLanguages

class LanguageManager: NSObject {
    
    private(set) var languageType: LanguageType!
    var bundle: Bundle? {
        guard let path = Bundle.main.path(forResource: languageType.rawValue, ofType: "lproj") else {
            return nil
        }
        return Bundle.init(path: path)
    }
    
    static let share = LanguageManager()
    private override init() {
        super.init()
        
        initLanguage()

    }
    
    func initLanguage() {
        guard let temp = UserDefaults.standard.value(forKey: LANGUAGE_SET) as? String else {
            return
        }
        
        let preferredLanguage = Bundle.main.preferredLocalizations.first!
        print("系统当前的语言:\(preferredLanguage)")
        print("当前app自定义语言:\(temp)")
        self.languageType = LanguageType.init(rawValue: temp) ?? .en
    }
    
    // MARK: - Public
    func changeLocalLanguage(type: LanguageType) {
        if type == languageType {
            return
        }
        
        self.languageType = type
        UserDefaults.standard.set(type.rawValue, forKey: LANGUAGE_SET)
    }
    
    func getLanguageType(languageChooseVC index: Int) -> LanguageType {
        switch index {
        case 0:
            return .zhHans
        case 1:
            return .zhHant
        default:
            return .en
        }
    }
}
