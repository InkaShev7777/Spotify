//
//  APIColler.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 21.12.2023.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init(){}
    
    struct Constens{
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error{
        case failedToGetData
    }
    
    //MARK: - Albums
    
    public func getAlbumDetails(for album: Album, completion: @escaping (Result<AlbumDetailsResponse, Error>) -> Void) {
        createRequest(
            with: URL(string: Constens.baseAPIURL + "/albums/" + album.id),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil  else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCurrentUserAlbums(completion: @escaping (Result<[Album], Error>) -> Void) {
        createRequest(with: URL(string: Constens.baseAPIURL + "/me/albums?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(LibraryAlbumsResponse.self, from: data)
                    completion(.success(result.items.compactMap({ $0.album })))
                }
                catch{
                    completion(.failure(error))
                    print(error)
                }
            }
            task.resume()
        }
    }
    
    public func saveAlbum(album: Album, complition: @escaping (Bool) -> Void) {
        createRequest(with: URL(string: Constens.baseAPIURL + "/me/albums"), type: .PUT) { baseRequest in
            var request = baseRequest
            let json = [
                "ids": [
                    album.id
                ]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data,
                      let code = (response as? HTTPURLResponse)?.statusCode,
                      error == nil else {
                    complition(false)
                    return
                }
                complition(code == 200)
            }
            task.resume()
        }
    }
    
    public func deleteAlbum(album: Album, complition: @escaping (Bool) -> Void){
        createRequest(with: URL(string: Constens.baseAPIURL+"/me/albums"), type: .DELETE) { baseRequest in
            var request = baseRequest
            let json = [
                "ids": [
                    album.id
                ]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data,
                      let code = (response as? HTTPURLResponse)?.statusCode,
                      error == nil else {
                    complition(false)
                    return
                }
                complition(code == 200)
            }
            task.resume()
        }
    }
    
    //MARK: - Playlists
    
    public func getPlaylistDetails(for playlist: Playlist, completion: @escaping (Result<PlaylistDetailsResponse, Error>) -> Void) {
        createRequest(
            with: URL(string: Constens.baseAPIURL + "/playlists/" + playlist.id),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil  else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Profile
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile,Error>) -> Void){
        createRequest(with: URL(string: Constens.baseAPIURL + "/me"), type: .GET){baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest){data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                }catch{
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Browse
    
    public func getNewReleasses(completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constens.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET){ request in
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getFeaturedPlayLists(completion: @escaping ((Result<FeaturedPlayListsResponse, Error>)) -> Void){
        createRequest(with: URL(string: Constens.baseAPIURL + "/browse/featured-playlists?limit=50"), type: .GET) {request in
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(FeaturedPlayListsResponse.self, from: data)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendations(genres:Set<String>, completion: @escaping ((Result<RecommendationsResponse, Error>)) -> Void){
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constens.baseAPIURL + "/recommendations?limit=40&seed_genres=\(seeds)"), type: .GET){request in
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendedGanres(completion: @escaping ((Result<RecommendedGenresResponse, Error>)) -> Void){
        createRequest(with: URL(string: Constens.baseAPIURL + "/recommendations/available-genre-seeds"), type: .GET) {request in
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Category
    
    public func getCategory(completion: @escaping (Result<[Category], Error>) -> Void) {
        createRequest(with: URL(string: Constens.baseAPIURL + "/browse/categories?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data,error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
                    let result =  try JSONDecoder().decode(AllCategoriesResponse.self, from: data)
                    completion(.success(result.categories.items))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCategoryPlaylists(category: Category, completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(with: URL(string: Constens.baseAPIURL + "/browse/categories/\(category.id)/playlists/?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data,error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
                    let result =  try JSONDecoder().decode(CategoryPlaylistsResponse.self, from: data)
                    let playlist = result.playlists.items
                    completion(.success(playlist))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Search
    
    public func search(with query: String, completion: @escaping (Result<[SearchResult], Error>) -> Void){
        createRequest(with: URL(string: Constens.baseAPIURL+"/search?limit=10&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"), type: .GET)
        {   request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data,error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                    var searchResults: [SearchResult] = []
                    searchResults.append(contentsOf: result.tracks.items.compactMap { .track(model: $0)})
                    searchResults.append(contentsOf: result.albums.items.compactMap { .album(model: $0)})
                    searchResults.append(contentsOf: result.playlists.items.compactMap { .playlist(model: $0)})
                    searchResults.append(contentsOf: result.artists.items.compactMap { .artist(model: $0)})
                    
                    completion(.success(searchResults))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    //MARK: - User
    
    public func getCurrentUserPlaylists(completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(with: URL(string: Constens.baseAPIURL + "/me/playlists/?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(LibraryPlaylistsResponse.self, from: data)
                    completion(.success(result.items))
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func createPlaylist(with name: String,description description: String, completion: @escaping (Bool) -> Void) {
        getCurrentUserProfile { [ weak self ] result in
            switch result {
            case .success(let profile):
                let urlString = Constens.baseAPIURL + "/users/\(profile.id)/playlists"
                
                self?.createRequest(with: URL(string: urlString), type: .POST) { baseRequest in
                    var request = baseRequest
                    let json = [
                        "name": name,
                        "description": description,
                        "public": false
                    ]
                    request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
                    let task = URLSession.shared.dataTask(with: request) { data, _, error in
                        guard let data = data, error == nil else {
                            completion(false)
                            return
                        }
                        
                        do{
                            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            if let response = result as? [String: Any], response["id"] as? String != nil {
                                print("I am OK")
                                completion(true)
                            }
                            else{
                                print("I am not  OK")
                                completion(false)
                            }
                        }
                        catch{
                            print(error.localizedDescription)
                            completion(false)
                        }
                    }
                    task.resume()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func addTrackToPlaylist(track: AudioTrack, playlist: Playlist, completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string:  Constens.baseAPIURL + "/playlists/\(playlist.id)/tracks"), type: .POST) { baseRequest in
            var request = baseRequest
            
            print("Count tracks in playlist: \(playlist.images.count)")
            
            let json = [
                "uris":["spotify:track:\(track.id)"],
                "position":playlist.images.count
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }
                
                do{
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let response = result as? [String: Any], response["snapshot_id"] as? String != nil {
                        completion(true)
                    }
                    else {
                        completion(false)
                    }
                    print(result)
                }
                catch{
                    print("Error: \(error)")
                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    public func removeTrackFromPlaylist(track: AudioTrack, playlist: Playlist, completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string:  Constens.baseAPIURL + "/playlists/\(playlist.id)/tracks"), type: .DELETE) { baseRequest in
            var request = baseRequest
            let json = [
                "tracks":[
                    [
                        "uri": "spotify:track:\(track.id)"
                    ]
                ],
                "snapshot_id": playlist.snapshot_id
            ]
            print("ID: \(playlist.id)")
            print("spotify:track:\(track.id)")
            print(playlist.snapshot_id)
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }
                
                do{
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let response = result as? [String: Any], response["snapshot_id"] as? String != nil {
                        completion(true)
                    }
                    print("Result: \(result)")
                }
                catch{
                    print("Error: \(error)")
                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Private
    
    enum HTTPMethod: String{
        case GET
        case POST
        case DELETE
        case PUT
    }
    
    private func createRequest(with url: URL?,type:HTTPMethod, completion: @escaping (URLRequest) -> Void){
        AuthManager.shared.withValidToken{token in
            guard let apiURL = url else{
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.timeoutInterval = 80
            request.httpMethod = type.rawValue
            completion(request)
        }
    }
}
