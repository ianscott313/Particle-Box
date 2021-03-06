//
//  CreateDocumentViewController.swift
//  Particle-Box
//
//  Created by Ian on 4/8/18.
//  Copyright (c) 2018 jumplabs. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit
import SwiftSpinner

protocol CreateDocumentViewControllerInput
{
    func presentAlert(_ alert: UIAlertController)
    func documentCreated(_ alert: UIAlertController)
}

protocol CreateDocumentViewControllerOutput
{
    func createDocument(document: BoxDocument)
}

class CreateDocumentViewController: UIViewController, CreateDocumentViewControllerInput, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate
{
    var output: CreateDocumentViewControllerOutput!
    var router: CreateDocumentRouter!
    
    var newDocument = BoxDocument()
    
    let kKey = 0
    let kValue = 1
    let kDeviceId = 2
    let kProductId = 3
    let rows = 4
    
    // MARK: Interface builder elements
    
    @IBOutlet weak var tableView: UITableView!
    
    static func storyboardInstance() -> CreateDocumentViewController? {
        let storyboard = UIStoryboard(name: String(describing: self),
                                      bundle: nil)
        return storyboard.instantiateInitialViewController() as? CreateDocumentViewController
    }
    
    
    // MARK: Object lifecycle
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        CreateDocumentConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "New Document"
        newDocument.scope = .device  //default value
        tableView.tableFooterView = UIView() //Get rid of empty bottom cells
    }
    
    // MARK: tableView datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SearchFilterTableViewCell
        cell?.textField.addTarget(self, action: #selector(CreateDocumentViewController.textFieldDidChange(_:)), for: .editingChanged)
        switch indexPath.row {
        case kKey:
            cell?.textLabel?.text = "Key"
            cell?.textField.placeholder = "key..."
            cell?.textField.tag = kKey
            cell?.textField.keyboardType = .asciiCapable
        case kValue:
            cell?.textLabel?.text = "Value"
            cell?.textField.placeholder = "value..."
            cell?.textField.tag = kValue
            cell?.textField.keyboardType = .asciiCapable
        case kDeviceId:
            cell?.textLabel?.text = "Device Id"
            cell?.textField.placeholder = "device id..."
            cell?.textField.tag = kDeviceId
            cell?.textField.keyboardType = .asciiCapable
        case kProductId:
            cell?.textLabel?.text = "Product Id"
            cell?.textField.placeholder = "product id..."
            cell?.textField.tag = kProductId
            cell?.textField.keyboardType = .numberPad
        default:
            print("unrecognized index in cellForRow")
        }
        
        return cell!
    }
    
    
    // MARK: tableView delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as? SearchFilterTableViewCell
        cell?.textField.becomeFirstResponder()
    }
    
    
    // MARK: textField target
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField.tag {
        case kKey:
            self.newDocument.key = textField.text!
            break
        case kValue:
            self.newDocument.value = textField.text!
            break
        case kDeviceId:
            self.newDocument.deviceId = textField.text!
            break
        case kProductId:
            self.newDocument.productId = Int(textField.text!)!
            break
        default:
            break
        }
    }
    
    // MARK: Event handling

    @IBAction func createPressed(_ sender: Any) {
        SwiftSpinner.show("Creating Document...")
        output.createDocument(document: newDocument)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        router.dismiss()
    }
    
    @IBAction func ScopeSegmentedControlChanged(_ sender: Any) {
        if let segmentedControl = sender as? UISegmentedControl {
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                self.newDocument.scope = .device
                break
            case 1:
                self.newDocument.scope = .user
                break
            case 2:
                self.newDocument.scope = .product
                break
            default:
                print("unrecognized scope selected")
                break
            }
        }
    }
    
    
    // MARK: View updates

    func presentAlert(_ alert: UIAlertController) {
        SwiftSpinner.hide()
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func documentCreated(_ alert: UIAlertController) {
        SwiftSpinner.hide()
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            self.router.dismiss()
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
