//
//  AuthManager.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 21.12.2023.
//

import Foundation

final class AuthManager{
    static let shared = AuthManager()
    
    struct Constants {
        static let clientID = "4a8e12d2b3734c14a6b7539ba30fe981"
        static let clientSecret = "d5ae0edbd3294cceb073c7f61a0f1705"
    }
    
    private init(){}
    
    public var signInURL : URL? {
        let base = "https://accounts.spotify.com/authorize"
        let scopes = "user-read-private"
        let redirect_uri = "https://www.iosacademy.io"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirect_uri)&show_dialog=true"
        return URL(string: string)
    }
    
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
    
    public func exchangeCodeForToken(code:String, completion: @escaping (Bool) -> Void){
        // Get Token
    }
    
    public func refreshAccessToken(){
        
    }
    
    private func cacheToken(){
        
    }
}
