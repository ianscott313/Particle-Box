//
//  BoxDocument.swift
//  Particle-Box
//
//  Created by Ian on 4/4/18.
//  Copyright © 2018 jumplabs. All rights reserved.
//

import Foundation

enum BoxDocumentScope: String {
    case device = "device"
    case user = "user"
    case product = "product"
}

class BoxDocument: NSObject {
    
    var key = ""
    var value = ""
    var scope: BoxDocumentScope?
    var deviceId = ""
    var productId = 0
    var updatedAt = Date()
    
}
