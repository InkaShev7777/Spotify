//
//  LibraryAlbumsViewController.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 04.01.2024.
//

import UIKit

class LibraryAlbumsViewController: UIViewController {
    
    var albums = [Album]()
    
    private let noAlbumsView = ActionLabelView()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifire)
        tableView.isHidden = true
        return tableView
    }()
    
    private var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        setUpNoAlbumsView()
        fetchData()
        observer = NotificationCenter.default.addObserver(
            forName: .albumSavedNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                self?.fetchData()
            })
    }
    
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noAlbumsView.frame = CGRect(x: (view.width-150)/2, y: (view.height-150)/2, width: 150, height: 150)
        tableView.frame = view.bounds
        
        let gestuer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        tableView.addGestureRecognizer(gestuer)
    }
    
    @objc func didLongPress(_ gestuer: UILongPressGestureRecognizer) {
        let location = gestuer.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: location) else {
            return
        }
        
        let albumForDelete = albums[indexPath.row]
        
        let actionSheet = UIAlertController(
            title: albumForDelete.name,
            message: "Do you really want to delete this album?",
            preferredStyle: .actionSheet
        )
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            strongSelf.deleteAlbum(with: albumForDelete, indexPath: indexPath)
           
        }))
        present(actionSheet,animated: true, completion: nil)
    }
    
    // Delete with long press
    func deleteAlbum(with albumForDelete: Album, indexPath indexPath: IndexPath) {
        APICaller.shared.deleteAlbum(album: albumForDelete) { success in
            DispatchQueue.main.sync {
                if success {
                    self.albums.remove(at: indexPath.row)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // Delete from album
    func deleteAlbum(with albumForDelete: Album) {
        var index = 0
        for album in albums {
            if album.name == albumForDelete.name {
                APICaller.shared.deleteAlbum(album: albumForDelete) { result in
                    DispatchQueue.main.async {
                        if result {
                            self.albums.remove(at: index)
                            self.tableView.reloadData()
                        }
                    }
                }
                return
            }
            index += 1
        }
    }
    
    private func setUpNoAlbumsView() {
        view.addSubview(noAlbumsView)
        noAlbumsView.delegate = self
        noAlbumsView.configure(with: ActionLabelViewViewModel(
            text: "You have not saved any albums yet.",
            actionTitle: "Brows"
        ))
    }
    
    private func fetchData() {
        albums.removeAll()
        APICaller.shared.getCurrentUserAlbums { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let albums):
                    self?.albums = albums
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func updateUI() {
        if albums.isEmpty {
            // Show Label
            noAlbumsView.isHidden = false
            tableView.isHidden = true
        }
        else{
            // Show table
            tableView.reloadData()
            noAlbumsView.isHidden = true
            tableView.isHidden = false
        }
    }
}
    
extension LibraryAlbumsViewController: ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        tabBarController?.selectedIndex = 0
    }
}

extension LibraryAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultSubtitleTableViewCell.identifire,
            for: indexPath
        ) as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }
        let album = albums[indexPath.row]
        cell.configure(
            with: SearchResultSubtitleTableViewCellViewModel(
                title: album.name,
                subtitle: album.artists.first?.name ?? "-",
                imageURL: URL(string: album.images.first?.url ?? ""))
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HapticsManager.shared.vibrateForSelection()
        let album = albums[indexPath.row]
        let vc = SavedAlbumsViewController(album: album)
        vc.delegate = self
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension LibraryAlbumsViewController: SavedAlbumsViewControllerDelegate {
    func savedAlbumsViewControllerDidDeleteAlbum(_ viewController: SavedAlbumsViewController) {
        deleteAlbum(with: viewController.album)
        if self.albums.isEmpty {
            updateUI()
        }
    }
}
