//
//  AlphabetSource.swift
//  contacts-app
//
//  Created by Dmitrii Titov on 25.03.17.
//  Copyright © 2017 Dmitrii Titov. All rights reserved.
//

import UIKit

private let sharedInstance = AlphabetSource()

enum AlphabetType {
    case russian
    case english
}

class AlphabetSource: NSObject {
    
    class var shared : AlphabetSource {
        return sharedInstance
    }

    func alphabet(type: AlphabetType) -> [String] {
        var res = [String]()
        switch type {
        case .russian:
            res = self.russianAlphabet()
            break
        case .english:
            res = self.englishAlphabet()
            break
        }
        return res
    }
    
    func russianAlphabet() -> [String] {
        return ["А",
                "Б",
                "В",
                "Г",
                "Д",
                "Е",
                "Ё",
                "Ж",
                "З",
                "И",
                "Й",
                "К",
                "Л",
                "М",
                "Н",
                "О",
                "П",
                "Р",
                "С",
                "Т",
                "У",
                "Ф",
                "Х",
                "Ц",
                "Ч",
                "Ш",
                "Щ",
                "Ъ",
                "Ы",
                "Ь",
                "Э",
                "Ю",
                "Я"
        ]
    }
    
    func englishAlphabet() -> [String] {
        return ["A",
                "B",
                "C",
                "D",
                "E",
                "F",
                "G",
                "H",
                "I",
                "J",
                "K",
                "L",
                "M",
                "N",
                "M",
                "P",
                "Q",
                "R",
                "S",
                "T",
                "U",
                "V",
                "W",
                "X",
                "Y",
                "Z"
        ]
    }
    
}
