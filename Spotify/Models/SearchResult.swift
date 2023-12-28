//
//  SearchResult.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 28.12.2023.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
