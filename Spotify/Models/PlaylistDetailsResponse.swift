//
//  PlaylistDetailsResponse.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 26.12.2023.
//

import Foundation

struct PlaylistDetailsResponse: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let tracks: PlaylistTracsResponse
}

struct PlaylistTracsResponse: Codable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
    let track: AudioTrack
}
