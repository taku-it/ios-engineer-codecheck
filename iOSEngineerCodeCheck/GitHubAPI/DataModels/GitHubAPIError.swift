//
//  GitHubAPIError.swift
//  iOSEngineerCodeCheck
//
//  Created by 生田拓登 on 2022/07/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

struct GitHubAPIError: Codable, Error {
    struct Error: Codable {
        var resource: String
        var field: String
        var code: String
    }
    
    var message: String
    var errors: [Error]
}
