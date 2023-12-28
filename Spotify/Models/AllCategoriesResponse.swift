//
//  AllCategoriesResponse.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 27.12.2023.
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}

