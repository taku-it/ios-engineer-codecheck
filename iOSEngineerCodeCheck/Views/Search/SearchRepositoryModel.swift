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
    var repositories: [Repository] { get }
    func searchRepositories(query: String, completion: @escaping ([Repository]) -> ())
    func cancel()
}

final class SearchRepositoryModel: SearchRepositoryModelInput {
    var task: URLSessionTask?
    var repositories: [Repository] = []
    
    func searchRepositories(query: String, completion: @escaping ([Repository]) -> ()) {
        
        guard let encodedQuery =
                query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let url =
                URL(string: "https://api.github.com/search/repositories?q=\(encodedQuery)")
        else { return }
        
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        task = URLSession.shared.dataTask(with: request, completionHandler: {
            [weak self] (data, _, error) in
            guard let data = data else { return }
            
            do {
                let repositories: Repositories = try decoder.decode(Repositories.self, from: data)
                self?.repositories = repositories.items
                completion(repositories.items)
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
    
}