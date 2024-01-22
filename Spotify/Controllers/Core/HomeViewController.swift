//
//  ViewController.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 21.12.2023.
//

import UIKit

enum BrowsSectionType {
    case newRelesses(viewModels: [NewReleasesCellViewModel])
    case featuredPlaylists(viewModels: [FeaturedPlaylistCellViewModel])
    case recommendedTracks(viewModels: [RecommendedTrackCellViewModel])
    
    var title: String {
        switch self {
        case .newRelesses:
            return "New Released Albums"
        case .featuredPlaylists:
            return "Featured Playlists"
        case .recommendedTracks:
            return "Recommended"
        }
    }
}

class HomeViewController: UIViewController {
    
    private var newAlbums: [Album] = []
    private var playLists: [Playlist] = []
    private var tracks: [AudioTrack] = []
    
    private var collectionView: UICollectionView = UICollectionView (
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout {sectionIndex, _ -> NSCollectionLayoutSection? in
            return HomeViewController.createSectionlayout(section: sectionIndex)
        }
    )
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private var sections = [BrowsSectionType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browse"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(
                systemName: "person.crop.circle.fill"
            ),
            style: .done,
            target: self,
            action: #selector(didTapSettings)
        )
        configureCollectionView()
        view.addSubview(spinner)
        addLongTapGester()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }

    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        
    }
    
    private func addLongTapGester() {
        let gester = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        collectionView.isUserInteractionEnabled = true
        collectionView.addGestureRecognizer(gester)
    }
    
    @objc func didLongPress(_ gester: UILongPressGestureRecognizer) {
        guard gester.state == .began else {
            return
        }
        
        let touchPoint = gester.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: touchPoint), indexPath.section == 2 else {
            return
        }
        
        let model = tracks[indexPath.row]
        
        let actionSheet = UIAlertController(
            title: model.name,
            message: "Would you like to add this to a playlist?",
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Add to Playlist", style: .default, handler: { [ weak self ] _ in
            DispatchQueue.main.async {
                let vc  = LibraryPlaylistsViewController()
                vc.selectionHendlet = { playlist in
                    APICaller.shared.addTrackToPlaylist(track: model, playlist: playlist) { success in
                        
                        if success {
                            let okAction = UIAlertAction(title: "OK", style: .cancel)
                            let alert = UIAlertController(title: "Information", message: "Song added to playlist!", preferredStyle: .alert)
                            alert.addAction(okAction)
                            self?.present(alert, animated: true)
                        }
                        else {
                            let okAction = UIAlertAction(title: "Cancel", style: .destructive)
                            let alert = UIAlertController(title: "Information", message: "Song not added to playlist!", preferredStyle: .alert)
                            alert.addAction(okAction)
                            self?.present(alert, animated: true)
                        }
                    }
                }
                vc.title = "Select Playlist"
                self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            }
        }))
        
        present(actionSheet, animated: true)
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        
        //
        //  CollectionView
        //
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.register(NewReleaseCollectionViewCell.self, 
                                forCellWithReuseIdentifier: NewReleaseCollectionViewCell.identifier)
        collectionView.register(FeaturePlaylistCollectionViewCell.self,
                                forCellWithReuseIdentifier: FeaturePlaylistCollectionViewCell.identifier)
        collectionView.register(RecommendedTrackCollectionViewCell.self, 
                                forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier)
        collectionView.register(
            TitleHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, 
            withReuseIdentifier: TitleHeaderCollectionReusableView.identifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
    }
    
    private static func createSectionlayout(section: Int) -> NSCollectionLayoutSection {
        let suplementaryViews = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        switch section {
        case 0:
            //Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(390)),
                                                                 subitem: item,
                                                                 count: 3)
            
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(390)),
                                                                     subitem: verticalGroup,
                                                                     count: 1)
            //Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = suplementaryViews
            return section
        case 1:
            //Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(400)),
                                                                 subitem: item,
                                                                 count: 2)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(400)),
                                                                     subitem: verticalGroup,
                                                                     count: 1)
            //Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = suplementaryViews
            return section
        case 2:
            //Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)),
                                                         subitem: item,
                                                         count: 1)
            //Section
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = suplementaryViews
            return section
            
        default:
            //Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(390)),
                                                         subitem: item,
                                                         count: 1)
            
            //Section
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = suplementaryViews
            return section
        }
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        
        var newReleases: NewReleasesResponse?
        var featuredPlaylist: FeaturedPlayListsResponse?
        var recommendations: RecommendationsResponse?
        
        //New Releases
        APICaller.shared.getNewReleasses { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let model): 
                newReleases = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        // Featured Playlists
        APICaller.shared.getFeaturedPlayLists { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let model): 
                featuredPlaylist = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        //Recommendeted Tracks
        APICaller.shared.getRecommendedGanres{ result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                APICaller.shared.getRecommendations(genres: seeds){ recomendedResults in
                    defer {
                        group.leave()
                    }
                    switch recomendedResults {
                    case .success(let model):
                        recommendations = model
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case.failure(let error): 
                print(error.localizedDescription)
            }
        }
    
        group.notify(queue: .main) {
            guard let newAlbums = newReleases?.albums.items,
                  let playlists = featuredPlaylist?.playlists.items,
                  let tracks = recommendations?.tracks else {
//                fatalError("Models are nil")
                return
            }
            
            self.configureModels(
                newAlbums: newAlbums,
                tracks: tracks,
                playLists: playlists
            )
        }
    }
    
    private func configureModels(
        newAlbums: [Album],
        tracks: [AudioTrack],
        playLists: [Playlist]
    ) {
        self.newAlbums = newAlbums
        self.playLists = playLists
        self.tracks = tracks
        
        sections.append(.newRelesses(viewModels: newAlbums.compactMap({
            return NewReleasesCellViewModel(
                name: $0.name,
                artworkURL: URL(string: $0.images.first?.url ?? ""),
                numberOfTracks: $0.total_tracks,
                artistName: $0.artists.first?.name ?? "-")
        })))
        sections.append(.featuredPlaylists(viewModels: playLists.compactMap({
            return FeaturedPlaylistCellViewModel(
                name: $0.name,
                artworkURL: URL(string: $0.images.first?.url ?? ""),
                creatorName: $0.owner.display_name
            )
        })))
        
        sections.append(.recommendedTracks(viewModels: tracks.compactMap({
            return RecommendedTrackCellViewModel(
                name: $0.name,
                artistName: $0.artists.first?.name ?? "-",
                artworkURL: URL(string: $0.album?.images.first?.url ?? ""))
        })))
        
        collectionView.reloadData()
    }
    
    @objc func didTapSettings(){
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
        case .newRelesses(let viewModels):
            return viewModels.count
        case .featuredPlaylists(let viewModels):
            return viewModels.count
        case .recommendedTracks(let viewModels):
            return viewModels.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        switch type {
        case .newRelesses(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier:  NewReleaseCollectionViewCell.identifier,
                for: indexPath
            ) as? NewReleaseCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .featuredPlaylists(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier:  FeaturePlaylistCollectionViewCell.identifier,
                for: indexPath
            ) as? FeaturePlaylistCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .recommendedTracks(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier:  RecommendedTrackCollectionViewCell.identifier,
                for: indexPath
            ) as? RecommendedTrackCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        HapticsManager.shared.vibrateForSelection()
        let section = sections[indexPath.section]
        switch section {
        case .featuredPlaylists:
            let playlist = playLists[indexPath.row]
            let vc = PlaylistViewController(playlist: playlist)
            vc.title = playlist.name
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .newRelesses:
            let album = newAlbums[indexPath.row]
            let vc = AlbumViewController(album: album)
            vc.title = album.name
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .recommendedTracks:
            let track = tracks[indexPath.row]
            PlaybackPresenter.shared.startPlayback(from: self, track: track)
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TitleHeaderCollectionReusableView.identifier,
            for: indexPath
        ) as? TitleHeaderCollectionReusableView,kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let section = indexPath.section
        let title =  sections[section].title
        header.configure(with: title)
        return header
    }
    
    private  func createSectionlayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0:
            //Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(390)),
                subitem: item,
                count: 3)
            
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(390)),
                subitem: verticalGroup,
                count: 1
            )
            //Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        case 1:
            //Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(400)),
                                                                 subitem: item,
                                                                 count: 2)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(400)),
                                                                     subitem: verticalGroup,
                                                                     count: 1)
            //Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            return section
        case 2:
            //Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)),
                                                         subitem: item,
                                                         count: 1)
            //Section
            let section = NSCollectionLayoutSection(group: group)
            return section
            
        default:
            //Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //Group
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(390)),
                                                         subitem: item,
                                                         count: 1)
            
            //Section
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
    
}
