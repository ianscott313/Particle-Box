//
//  BoxAPIService.swift
//  Particle-Box
//
//  Created by Ian on 4/4/18.
//  Copyright © 2018 jumplabs. All rights reserved.
//

import Foundation
import SwiftyJSON

enum JSONError: String, Error {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}

class BoxAPIService: NSObject {
    
    static let shared = BoxAPIService()

    
    let token = "ABC123"
    let baseURL = "https://virtserver.swaggerhub.com/particle-iot/box/0.1/box"

    func getDocuments(scope: BoxDocumentScope,
                      deviceId: String?,
                      productId: Int?,
                      filter: String?,
                      page: Int?,
                      perPage: Int? = 10,
                      completion: @escaping (_ documents: [BoxDocument]?, _ error: Error?) -> ()) {
        
        var urlString = "\(baseURL)?per_page=\(String(describing: perPage!))"
        
        if let device = deviceId {
            urlString.append("&device_id=\(device)")
        }
        
        if let product = productId {
            urlString.append("&product_id=\(String(describing: product))")
        }
        
        if let filterString = filter {
            urlString.append("&filter=\(filterString)")
        }
        
        if let pageNumber = page {
            urlString.append("&page=\(String(describing: pageNumber))")
            
        }

        var req = URLRequest(url: URL(string: urlString)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30.0)
        req.httpMethod = "GET"
        
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            do {
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                
                if data != nil {
                    var array = [BoxDocument]()
                    let json = try JSON(data: data!)
                    if let dataArray = json["data"].array {
                        for subJson in dataArray {
                            let doc = BoxDocument(dictionary: subJson.dictionaryObject! as NSDictionary)
                            array.append(doc)
                        }
                    }
                    
                    completion(array, nil)
                }
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }

        }.resume()
    }
    
}
