//
//  AuthResponse.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 22.12.2023.
//

import Foundation

struct AuthResponse: Codable{
    let access_token: String
    let expires_in : Int
    let refresh_token :String?
    let scope: String
    let token_type: String
}
