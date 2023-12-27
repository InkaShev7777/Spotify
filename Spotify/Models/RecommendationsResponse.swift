//
//  RecommendationsResponse.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 25.12.2023.
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}

