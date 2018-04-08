//
//  BoxDocument.swift
//  Particle-Box
//
//  Created by Ian on 4/4/18.
//  Copyright © 2018 jumplabs. All rights reserved.
//

import Foundation
import SwiftyJSON

enum BoxDocumentScope: String {
    case device = "device"
    case user = "user"
    case product = "product"
    case none = ""
}

class BoxDocument: NSObject {
    
    var key = ""
    var value = ""
    var scope: BoxDocumentScope?
    var deviceId = ""
    var productId = 0
    var updatedAt = Date()
    
    init(dictionary: NSDictionary) {
        super.init()
        
        if dictionary["key"] != nil {
            self.key =  (dictionary["key"] as? String)!
        }
        
        if dictionary["value"] != nil {
            self.value = (dictionary["value"] as? String)!
        }
        
        if dictionary["scope"] != nil {
            self.scope = BoxDocumentScope(rawValue: (dictionary["scope"] as? String)!)
        }
        
        if dictionary["device_id"] != nil {
            self.deviceId = (dictionary["device_id"] as? String)!
        }
        
        if dictionary["product_id"] != nil {
            self.productId = (dictionary["product_id"] as? Int)!
        }
        
        if dictionary["updated_at"] != nil {
            let dateString = (dictionary["updated_at"] as? String)!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            self.updatedAt = dateFormatter.date(from:dateString)!
        }
        
        
        
    }
    
}
