//
//  BoxAPIService.swift
//  Particle-Box
//
//  Created by Ian on 4/4/18.
//  Copyright © 2018 jumplabs. All rights reserved.
//

import Foundation
import SwiftyJSON

class BoxAPIService: NSObject {
    
    static let shared = BoxAPIService()

    let baseURL = "https://virtserver.swaggerhub.com/particle-iot/box/0.1/box"

    func getDocuments(filter: BoxDocumentSearchFilter,
                      completion: @escaping (_ documents: [BoxDocument]?, _ error: Error?) -> ()) {
        
        var urlString = "\(baseURL)?per_page=\(String(describing: filter.perPage!))"
        
        if filter.scope != .none {
            urlString.append("&scope=\(filter.scope.rawValue)")
        }
        
        if let device = filter.deviceId {
            urlString.append("&device_id=\(device)")
        }
        
        if let product = filter.productId {
            urlString.append("&product_id=\(String(describing: product))")
        }
        
        if let filterString = filter.filter {
            urlString.append("&filter=\(filterString)")
        }
        
        if let pageNumber = filter.page {
            urlString.append("&page=\(String(describing: pageNumber))")
            
        }
        
        print(urlString)
        let req = BoxAPIRequest(url: urlString, httpMethod: .get)
        URLSession.shared.dataTask(with: req as URLRequest) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            if data != nil {
                var array = [BoxDocument]()
                let json = try! JSON(data: data!)
                if let dataArray = json["data"].array {
                    for subJson in dataArray {
                        let doc = BoxDocument(dictionary: subJson.dictionaryObject! as NSDictionary)
                        array.append(doc)
                    }
                }
                completion(array, nil)
            }
            
        }.resume()
    }
    
    
    func getDocument(key: String,
                     filter: BoxDocumentSearchFilter,
                     completion: @escaping (_ document: BoxDocument?, _ error: Error?) -> ()) {
        
        var urlString = "\(baseURL)/\(key)"
        
        if filter.scope != .none {
            urlString.append("&scope=\(filter.scope.rawValue)")
        }
        
        if let device = filter.deviceId {
            urlString.append("&device_id=\(device)")
        }
        
        if let product = filter.productId {
            urlString.append("&product_id=\(String(describing: product))")
        }
        
        print(urlString)
        let req = BoxAPIRequest(url: urlString, httpMethod: .get)
        URLSession.shared.dataTask(with: req as URLRequest) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            if data != nil {
                let json = try! JSON(data: data!)
                let doc = BoxDocument(dictionary: json.dictionaryObject! as NSDictionary)
                completion(doc, nil)
            }
            
            }.resume()
    }
}
