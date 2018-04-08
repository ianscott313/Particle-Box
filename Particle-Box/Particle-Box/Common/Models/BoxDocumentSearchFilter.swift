//
//  BoxDocumentSearchFilter.swift
//  Particle-Box
//
//  Created by Ian on 4/7/18.
//  Copyright © 2018 jumplabs. All rights reserved.
//

import Foundation

class BoxDocumentSearchFilter: NSObject, NSCopying {
    
    public var filter: String?
    public var deviceId: String?
    public var productId: Int?
    public var page: Int?
    public var perPage: Int? = 10
    public var scope = BoxDocumentScope.none
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = BoxDocumentSearchFilter()
        copy.filter = filter
        copy.deviceId = deviceId
        copy.productId = productId
        copy.page = page
        copy.perPage = perPage
        copy.scope = scope
        return copy
    }
}
