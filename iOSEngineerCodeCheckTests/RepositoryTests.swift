//
//  RepositoryTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 生田拓登 on 2022/07/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import XCTest
@testable import iOSEngineerCodeCheck

class RepositoryTests: XCTestCase {
    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let data = Repository.exampleJSON.data(using: .utf8)!
        let repository = try jsonDecoder.decode(Repository.self, from: data)
        XCTAssertEqual(repository.id, 44838949)
        XCTAssertEqual(repository.fullName, "apple/swift")
        XCTAssertEqual(repository.owner.login, "apple")
    }
}
