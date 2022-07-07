//
//  RepositoryModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 生田拓登 on 2022/07/07.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

struct Repositories: Codable {
    let items: [Repository]
}

struct Repository: Codable {
    let id: String
    let fullName: String
    let language: String
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let owner: Owner
}

struct Owner: Codable {
    let avatarUrl: String
}
