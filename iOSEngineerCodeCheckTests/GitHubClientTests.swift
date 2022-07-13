//
//  GitHubClientTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 生田拓登 on 2022/07/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest
import Foundation
@testable import iOSEngineerCodeCheck

class GitHubClientTests: XCTestCase {
    var httpClient: StubHTTPClient!
    var gitHubClient: GitHubClient!
    
    override func setUp() {
        super.setUp()
        httpClient = StubHTTPClient()
        gitHubClient = GitHubClient(httpClient: httpClient)
    }
    
}
