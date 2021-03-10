//
//  DataModel.swift
//  NYTStories
//
//  Created by Luiza on 10.03.2021.
//  Copyright © 2021 Luiza. All rights reserved.
//

import Foundation

struct Stories: Codable {
    let num_results: Int?
    let results: [Story]?
}

struct Story: Codable {
    let id: Int?
    let title: String?
    let url: URL?
}
