//
//  AuthManager.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 21.12.2023.
//

import Foundation

final class AuthManager{
    static let shared = AuthManager()
    
    private init(){}
    
    var isSignedIn:Bool{
        return false
    }
    
    private var accessToken: String?{
        return nil
    }
    
    private var refreshToken: String?{
        return nil
    }
    
    private var tokenExperationData: Bool?{
        return nil
    }
    
    private var shouldRefreshToken: Bool?{
        return false
    }
}
