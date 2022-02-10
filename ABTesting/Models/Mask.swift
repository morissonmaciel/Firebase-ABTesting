//
//  Mask.swift
//  ABTesting
//
//  Created by Morisson Ferreira Maciel on 11/01/22.
//

import Foundation

struct Mask {
    var maskFormat: String
}

extension Mask {
    
    public func formateValue(_ value: String) -> String {
        let cleanNumber = value.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = maskFormat
        var result = ""
        var index = cleanNumber.startIndex
        
        for ch in mask where index < cleanNumber.endIndex {
            if ch == "#" {
                result.append(cleanNumber[index])
                index = cleanNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        
        return result
    }
}
