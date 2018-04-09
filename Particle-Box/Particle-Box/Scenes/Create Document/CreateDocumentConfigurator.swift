//
//  CreateDocumentConfigurator.swift
//  Particle-Box
//
//  Created by Ian on 4/8/18.
//  Copyright (c) 2018 jumplabs. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension CreateDocumentViewController: CreateDocumentPresenterOutput
{

}

extension CreateDocumentInteractor: CreateDocumentViewControllerOutput
{
}

extension CreateDocumentPresenter: CreateDocumentInteractorOutput
{
}

class CreateDocumentConfigurator
{
    // MARK: Object lifecycle
    
    static let sharedInstance = CreateDocumentConfigurator()
    
    // MARK: Configuration
    
    func configure(viewController: CreateDocumentViewController)
    {
        let router = CreateDocumentRouter()
        router.viewController = viewController
        
        let presenter = CreateDocumentPresenter()
        presenter.output = viewController
        
        let interactor = CreateDocumentInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}