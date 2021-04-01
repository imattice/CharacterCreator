//
//  FeatureTests.swift
//  CharacterCreatorTests
//
//  Created by Ike Mattice on 12/17/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import XCTest
@testable import CharacterCreator


class FeatureTests: XCTestCase {
    func testOptions() throws {
        let elfFeatures = SubraceRecord.record(for: "high elf")!.features.ofType(SelectableFeature.self)
        
        XCTAssert(elfFeatures.count == 2)
    }
}
