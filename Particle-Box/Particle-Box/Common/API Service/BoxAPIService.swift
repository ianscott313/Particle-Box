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
    
    func deleteDocument(document: BoxDocument,
                        completion: @escaping (_ responseCode: Int?, _ error: Error?) -> ()) {
        
        var urlString = "\(baseURL)/\(document.key)"
        
        if document.scope != .none {
            if let scope = document.scope?.rawValue {
                urlString.append("&scope=\(scope)")
            }
        }
        
        if !document.deviceId.isEmpty {
            urlString.append("&device_id=\(document.deviceId)")
        }
        
        if document.productId != 0 {
            urlString.append("&product_id=\(String(describing: document.productId))")
        }
        
        print(urlString)
        let req = BoxAPIRequest(url: urlString, httpMethod: .delete)
        URLSession.shared.dataTask(with: req as URLRequest) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            let r = response as? HTTPURLResponse
            completion(r?.statusCode, nil)
            
            }.resume()
    }
    
    func createDocument(document: BoxDocument,
                        completion: @escaping (_ responseCode: Int?, _ error: Error?) -> ()) {
        
        let urlString = baseURL
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.string(from: Date())
        print()
        
        var scope = ""
        if let unwrappedScope = document.scope?.rawValue {
            scope = unwrappedScope
        }
        
        let json = JSON(["key": document.key,
                         "value": document.value,
                         "scope": scope,
                         "device_id": document.deviceId,
                         "product_id": String(describing: document.productId),
                         "updated_at": date])
        
        let req = BoxAPIRequest(url: urlString, httpMethod: .post)
        let rawData = try! json.rawData()
        req.httpBody = rawData
        URLSession.shared.dataTask(with: req as URLRequest) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            let r = response as? HTTPURLResponse
            completion(r?.statusCode, nil)
            
            }.resume()
    }
}
