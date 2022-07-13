//
//  SearchResponse.swift
//  iOSEngineerCodeCheck
//
//  Created by 生田拓登 on 2022/07/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

struct SearchResponse<Item: Codable>: Codable {
    var totalCount: Int
    var items: [Item]
}
