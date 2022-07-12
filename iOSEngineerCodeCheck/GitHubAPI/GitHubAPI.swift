//
//  GitHubAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by 生田拓登 on 2022/07/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

final class GitHubAPI {
    struct SearchRepositories: GitHubRequest {
        typealias Response = SearchResponse<Repository>
        
        let keyword: String
        
        var path: String {
            return "/search/repositories"
        }
        
        var method: HTTPMethod {
            return .get
        }
        
        var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: "q", value: keyword)]
        }
        
    }
}
