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
    
    private func makeHTTPClientResult(statusCode: Int, json: String) -> Result<(Data, HTTPURLResponse), Error> {
        return .success((
            json.data(using: .utf8)!,
            HTTPURLResponse(
                url: URL(string: "https://api.github.com/search/repositories")!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil)!
        ))
    }
    
    func testSuccess() {
        httpClient.result = makeHTTPClientResult(
            statusCode: 200,
            json: GitHubAPI.SearchRepositories.Response.exampleJSON)
        
        let request = GitHubAPI.SearchRepositories(keyword: "swift")
        let apiExpectation = expectation(description: "")
        gitHubClient.send(request: request) { result in
            switch result {
            case .success(let response):
                let repository = response.items.first
                XCTAssertEqual(repository?.fullName, "apple/swift")
            default:
                XCTFail("unexpected result: \(result)")
            }
            apiExpectation.fulfill()
        }
        
        wait(for: [apiExpectation], timeout: 3)
    }
    
    func testFailureByConnectionError() {
        httpClient.result = .failure(URLError(.cannotConnectToHost))
        
        let request = GitHubAPI.SearchRepositories(keyword: "swift")
        let apiExpectation = expectation(description: "")
        gitHubClient.send(request: request) { result in
            switch result {
            case .failure(.connectionError):
                break
            default:
                XCTFail("unexpected result: \(result)")
            }
            apiExpectation.fulfill()
        }
        
        wait(for: [apiExpectation], timeout: 3)
    }
}
