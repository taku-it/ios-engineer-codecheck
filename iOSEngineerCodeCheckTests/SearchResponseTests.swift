//
//  SearchResponseTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 生田拓登 on 2022/07/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import XCTest
@testable import iOSEngineerCodeCheck

class SearchResponseTests : XCTestCase {
    func testDecodeRepositories() throws {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let data = SearchResponse<Repository>.exampleJSON.data(using: .utf8)!
        let response = try jsonDecoder.decode(SearchResponse<Repository>.self, from: data)
        XCTAssertEqual(response.totalCount, 141722)
        XCTAssertEqual(response.items.count, 3)
        
        let firstRepository = response.items.first
        XCTAssertEqual(firstRepository?.owner.login, "apple")
        XCTAssertEqual(firstRepository?.fullName, "apple/swift")
    }
}
