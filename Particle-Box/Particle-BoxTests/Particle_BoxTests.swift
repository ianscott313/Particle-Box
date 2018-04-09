//
//  Particle_BoxTests.swift
//  Particle-BoxTests
//
//  Created by Ian on 4/4/18.
//  Copyright © 2018 jumplabs. All rights reserved.
//

import XCTest
import Mockingjay
@testable import Particle_Box

class Particle_BoxTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetDocuments() {
        let body = [ "data": "test" ]
        stub(everything, json(body))
        
        let expectation = self.expectation(description: "testGetDocuments")
        
        let service = BoxAPIService()
        let filter = BoxDocumentSearchFilter()
        
        
        service.getDocuments(filter: filter) { (documents, error) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
        }
    }
    
    func testGetDocumentByKey() {
        let body = [ "data": "test" ]
        stub(everything, json(body))
        
        let expectation = self.expectation(description: "testGetDocuments")
        
        let service = BoxAPIService()
        let filter = BoxDocumentSearchFilter()
        
        service.getDocument(key: "Test", filter: filter) { (document, error) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
        }
    }
    
    func testDeleteDocumentByKey() {

        stub(everything, http(204))
        
        let expectation = self.expectation(description: "testGetDocuments")
        
        let service = BoxAPIService()
        let document = BoxDocument()
        
        service.deleteDocument(document: document) { (response, error) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
        }
    }
    
    func testCreateNewDocument() {
        
        stub(everything, http(201))
        
        let expectation = self.expectation(description: "testGetDocuments")
        
        let service = BoxAPIService()
        let document = BoxDocument()
        
        service.createDocument(document: document) { (response, error) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
        }
    }
    
    func testIsDocumentDataValid() {
        let document = BoxDocument()
        document.scope = .device
        document.key = "test"
        document.value = "100"
        document.deviceId = "123"
        document.productId = 123
        
        let interactor = CreateDocumentInteractor()
        XCTAssertTrue(interactor.isDocumentDataValid(document: document))
    }
    
}
