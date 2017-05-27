//
//  History.swift
//  W07_Tip_Calculator_NIT
//
//  Created by Cntt16 on 5/27/17.
//  Copyright © 2017 Cntt16. All rights reserved.
//

import Foundation

class History {
    var date: String?
    var billAmount: Double?
    var tipAmount: Double?
    var tipResult: Double?
    var totalAmount: Double?
    
    init(arr: [String:Any]) {
        date        = arr["date"]           as? String
        billAmount  = arr["billAmount"]     as? Double
        tipAmount   = arr["tipAmount"]      as? Double
        tipResult   = arr["tipResult"]      as? Double
        totalAmount = arr["totalAmount"]    as? Double
    }
}
