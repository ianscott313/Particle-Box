//
//  DocumentSearchRouter.swift
//  Particle-Box
//
//  Created by Ian on 4/4/18.
//  Copyright (c) 2018 jumplabs. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol DocumentSearchRouterInput
{

}

class DocumentSearchRouter: DocumentSearchRouterInput
{
    weak var viewController: DocumentSearchViewController!
    
    // MARK: Navigation
    
    func showSearchFilter() {
        let filterVC = DocumentSearchFilterViewController.storyboardInstance()
        filterVC?.currentFilter = viewController.searchFilter
        let navController = UINavigationController(rootViewController: filterVC!)
        viewController.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func showCreateDocument() {
        let createVC = CreateDocumentViewController.storyboardInstance()
        let navController = UINavigationController(rootViewController: createVC!)
        viewController.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func showDocumentView(document: BoxDocument) {
        let documentVC = DocumentDetailViewController.storyboardInstance()
        documentVC?.document = document
        viewController.navigationController?.pushViewController(documentVC!, animated: true)
    }

}
