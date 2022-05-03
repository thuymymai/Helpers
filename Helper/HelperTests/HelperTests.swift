//
//  HelperTests.swift
//  HelperTests
//
//  Created by SonDang, MyMai, AnHuynh on 1.4.2022.
//

import XCTest
import CoreData
import SwiftUI

class HelperTests: XCTestCase {
    
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.userId, ascending: true)]) var results: FetchedResults<User>
    
    lazy var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        let container = NSPersistentContainer(name: "UserData")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        let context = HelperTests().persistentContainer.newBackgroundContext()
        self.measure {
            UserViewModel().fetchData(context: context)
        }
    }

    func testAddData() {
        let context = HelperTests().persistentContainer.newBackgroundContext()
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in return true}
        let newUser = User(context: context)
        newUser.userId = 21
        newUser.fullname = "test"
        newUser.password = "123456a@"
        newUser.email = "test@a.fi"
        newUser.phone = "1234"
        newUser.type = "v"
        newUser.availability = ""
        newUser.note = ""
        newUser.location = ""
        newUser.lat = 0.0
        newUser.long = 0.0
        newUser.need = ""
        newUser.chronic = ""
        newUser.allergies = ""
        
        try! context.save()
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }

    func testConvertDouble() {
        let number = "4.3"
        XCTAssertEqual(4.3, (number as NSString).doubleValue)
    }
    
}
