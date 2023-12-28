//
//  FeaturedPlayListsResponse.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 25.12.2023.
//

import Foundation

struct FeaturedPlayListsResponse: Codable {
    let playlists: PlaylistResponse
}

struct CategoryPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
