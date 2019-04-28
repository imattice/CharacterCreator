//
//  BackgroundClassTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 4/27/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

//import XCTest
//
//class BackgroundClassTests: XCTestCase {
//
//    override func setUp() {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}

import XCTest
@testable import CharacterCreator

class BackgroundClassTests: XCTestCase {
	var criminal: Background!
	var acolyte: Background!

	override func setUp() {
		super.setUp()

		criminal 	= Background(name: "criminal")
		acolyte		= Background(name: "acolyte")
	}
	override func tearDown() {
		super.tearDown()
		criminal 	= nil
		acolyte		= nil
	}

	func testLanguage() {
		let criminalLanguages = criminal.languages()
		let acolyteLanguages 	= acolyte.languages()

		XCTAssertEqual(criminalLanguages, nil)
	}
	func testExample() {
		// This is an example of a functional test case.
	}
	func testPerformanceExample() {
		// This is an example of a performance test case.
		self.measure {
			// Put the code you want to measure the time of here.
		}
	}
}

