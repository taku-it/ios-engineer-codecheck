//
//  GitHubClient.swift
//  iOSEngineerCodeCheck
//
//  Created by 生田拓登 on 2022/07/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

class GitHubClient {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func send<Request: GitHubRequest>(request: Request, completion: @escaping (Result<Request.Response, GitHubClientError>) -> Void){
        let urlRequest = request.buildURLRequest()
        
        httpClient.sendRequest(urlRequest) { result in
            switch result {
            case .success((let data, let urlResponse)):
                do {
                    let response = try request.response(from: data, urlResponse: urlResponse)
                    completion(Result.success(response))
                } catch let error as GitHubAPIError {
                    completion(Result.failure(.apiError(error)))
                } catch {
                    completion(Result.failure(.responseParseError(error)))
                }
            case .failure(let error):
                completion(.failure(.connectionError(error)))
            }
        }
    }
}
