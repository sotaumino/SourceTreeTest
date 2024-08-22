//
//  MyData.swift
//  Chapter5-3
//
//  Created by 海野 颯汰   on 2024/08/21.
//

import Foundation

class MyData: NSObject, NSSecureCoding {
    
    static var supportsSecureCoding: Bool {
        return true
    }
        
    var valueString : String?
    
    override init () {
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(valueString, forKey: "valueString")
    }
    
    required init?(coder Decoder: NSCoder) {
        valueString = Decoder.decodeObject(forKey: "valueString") as? String
    }
}
