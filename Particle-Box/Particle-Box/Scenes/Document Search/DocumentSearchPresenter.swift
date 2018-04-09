//
//  DocumentSearchPresenter.swift
//  Particle-Box
//
//  Created by Ian on 4/4/18.
//  Copyright (c) 2018 jumplabs. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol DocumentSearchPresenterInput
{
    func updateDataSource(documents: [BoxDocument])
    func createAlert(_ message: String)
    func deleteDocument(document: BoxDocument)
}

protocol DocumentSearchPresenterOutput: class
{
    func presentNewDocuments(documents: [BoxDocument])
    func presentAlert(_ alert: UIAlertController)
    func deleteDocument(document: BoxDocument)
}

class DocumentSearchPresenter: DocumentSearchPresenterInput
{
    weak var output: DocumentSearchPresenterOutput!
    
    // MARK: Presentation logic
    
    func updateDataSource(documents: [BoxDocument]) {
        output.presentNewDocuments(documents: documents)
    }
    
    func createAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        output.presentAlert(alert)
    }
    
    func deleteDocument(document: BoxDocument) {
        output.deleteDocument(document: document)
    }

}
