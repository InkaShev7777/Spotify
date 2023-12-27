//
//  AlbumDetailsResponse.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 26.12.2023.
//

import Foundation


struct AlbumDetailsResponse: Codable {
    let album_type: String
    let artists: [Artist]
    let available_markets: [String]
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let label: String
    let name: String
    let tracks: TracsResponse
    
}

struct TracsResponse: Codable {
    let items: [AudioTrack]
}
