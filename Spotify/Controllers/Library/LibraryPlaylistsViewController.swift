//
//  LiraryPlaylistsViewController.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 04.01.2024.
//

import UIKit

class LibraryPlaylistsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        APICaller.shared.getCurrentUserPlaylists { result in
            switch result {
            case .success(let playlists): break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

