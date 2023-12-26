//
//  SettingsModels.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 22.12.2023.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
