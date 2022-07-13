//
//  SearchRepositoryModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 生田拓登 on 2022/07/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchRepositoryModelInput {
    var task: URLSessionTask? { get }
    func searchRepositories(query: String, completion: @escaping (Result<[Repository],GitHubClientError>) -> ())
    func cancel()
}

final class SearchRepositoryModel: SearchRepositoryModelInput {
    var task: URLSessionTask?
    
    func searchRepositories(query: String, completion: @escaping (Result<[Repository],GitHubClientError>) -> ()) {
        
        guard let encodedQuery =
                query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        else { return }
        
        let client = GitHubClient(httpClient: URLSession.shared)
        let request = GitHubAPI.SearchRepositories(keyword: encodedQuery)
        client.send(request: request) { result in
            switch result {
            case .success(let response):
                completion(Result.success(response.items))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func cancel() {
        task?.cancel()
    }
    
}
