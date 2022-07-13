//
//  GitHubAPIErrorTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 生田拓登 on 2022/07/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import XCTest
@testable import iOSEngineerCodeCheck

class GitHubAPIErrorTests : XCTestCase {
    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        let data = GitHubAPIError.exampleJSON.data(using: .utf8)!
        let error = try jsonDecoder.decode(GitHubAPIError.self, from: data)
        XCTAssertEqual(error.message, "Validation Failed")
        
        let firstError = error.errors.first
        XCTAssertEqual(firstError?.field, "q")
        XCTAssertEqual(firstError?.code, "missing")
        XCTAssertEqual(firstError?.resource, "Search")
    }
}
