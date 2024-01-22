//
//  TabBarViewController.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 21.12.2023.
//

import UIKit
import AVKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vcHome = HomeViewController()
        let vcSearch = SearchViewController()
        let vcLibrary = LibraryViewController()
        
        vcHome.title = "Brows"
        vcSearch.title = "Search"
        vcLibrary.title = "Your Library"
        
        vcHome.navigationItem.largeTitleDisplayMode = .always
        vcSearch.navigationItem.largeTitleDisplayMode = .always
        vcLibrary.navigationItem.largeTitleDisplayMode = .always

        
        let navHome = UINavigationController(rootViewController: vcHome)
        let navSearch = UINavigationController(rootViewController: vcSearch)
        let navLibrary = UINavigationController(rootViewController: vcLibrary)
        
        navHome.navigationBar.tintColor = .label
        navSearch.navigationBar.tintColor = .label
        navLibrary.navigationBar.tintColor = .label
        
        navHome.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        navSearch.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        navLibrary.tabBarItem = UITabBarItem(title: "Your Library", image: UIImage(systemName: "books.vertical"), tag: 3)
        
        
        navHome.navigationBar.prefersLargeTitles = true
        navSearch.navigationBar.prefersLargeTitles = true
        navLibrary.navigationBar.prefersLargeTitles = true
        
        setViewControllers([navHome,navSearch,navLibrary], animated: false)
        
        
    }
}
