//
//  DocumentView.swift
//  Particle-Box
//
//  Created by Ian on 4/9/18.
//  Copyright © 2018 jumplabs. All rights reserved.
//

import Foundation
import UIKit

class DocumentViewController: UIViewController {
    
    var document = BoxDocument()
    
    // MARK: Interface builder elements

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var scopeLabel: UILabel!
    @IBOutlet weak var deviceIdLabel: UILabel!
    @IBOutlet weak var productIdLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    
    
    static func storyboardInstance() -> DocumentViewController? {
        let storyboard = UIStoryboard(name: String(describing: self),
                                      bundle: nil)
        return storyboard.instantiateInitialViewController() as? DocumentViewController
    }
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Document"
        
        keyLabel.text = document.key
        valueLabel.text = document.value
        scopeLabel.text = document.scope?.rawValue
        deviceIdLabel.text = document.deviceId
        productIdLabel.text = String(describing: document.productId)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.string(from: document.updatedAt)
        updatedAtLabel.text = date
    }
}
