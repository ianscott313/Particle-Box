//
//  DocumentSearchFilterRouter.swift
//  Particle-Box
//
//  Created by Ian on 4/8/18.
//  Copyright (c) 2018 jumplabs. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol DocumentSearchFilterRouterInput
{

}

class DocumentSearchFilterRouter: DocumentSearchFilterRouterInput
{
    weak var viewController: DocumentSearchFilterViewController!
    
    // MARK: Navigation
    
    func dismiss() {
        viewController.navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
