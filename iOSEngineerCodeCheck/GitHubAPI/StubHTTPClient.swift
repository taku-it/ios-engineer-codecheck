//
//  StubHTTPClient.swift
//  iOSEngineerCodeCheck
//
//  Created by 生田拓登 on 2022/07/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

class StubHTTPClient : HTTPClient {
    var result: Result<(Data, HTTPURLResponse), Error> = .success((
        Data(),
        HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)!))
    
    func sendRequest(_ urlRequest: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
            completion(self.result)
        }
    }
}
