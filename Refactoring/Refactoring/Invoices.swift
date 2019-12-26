//
//  Invoices.swift
//  Refactoring
//
//  Created by yrion on 2019/12/25.
//  Copyright © 2019 yrion. All rights reserved.
//

import Foundation

struct Invoice {
    var customer: String?
    var performances: [Performance]?
}

struct Performance {
    var playID: String?
    var audience: Int?
}
