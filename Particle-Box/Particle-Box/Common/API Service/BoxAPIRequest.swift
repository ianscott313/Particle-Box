//
//  BoxAPIRequest.swift
//  Particle-Box
//
//  Created by Ian on 4/7/18.
//  Copyright © 2018 jumplabs. All rights reserved.
//

import Foundation

enum httpMethodType: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

class BoxAPIRequest: NSMutableURLRequest {
    
    let token = "ABC123"
    
    convenience init(url: String, httpMethod: httpMethodType) {
        
        self.init(url: URL(string: url)!, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30.0)
        self.httpMethod = httpMethod.rawValue
        self.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        self.setValue("application/json", forHTTPHeaderField: "Accept")
    }
}
