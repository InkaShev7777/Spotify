//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 21.12.2023.
//

import UIKit
import SDWebImage

protocol PlayerViewControllerDelegate: AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBackward()
    func didSlideSlider(_ value: Float)
}

class PlayerViewController: UIViewController {
    
    weak var dataSource: PlayerDataSource?
    weak var delegate: PlayerViewControllerDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let controlsView = PlayerControlsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        controlsView.delegate = self
        configureBarButtons()
        configure()
        DispatchQueue.main.async {
            print("Time of song now: \(self.dataSource?.fullTime)")
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0, y: 50, width: view.width, height: view.width)
        controlsView.frame = CGRect(
            x: 10,
            y: imageView.bottom+10,
            width: view.width-20,
            height: view.height-imageView.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-15
        )
    }
    
    private func configure() {
        imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
        controlsView.configure(with: PlayerControlsViewViewModel(
            title: dataSource?.songName,
            subtitle: dataSource?.subtitle,
            timeNow: dataSource?.fullTime)
        )
<<<<<<< Updated upstream
=======
        
>>>>>>> Stashed changes
    }
    
    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapClose)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapAction)
        )
        
        navigationController?.navigationBar.tintColor = .darkGray
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapAction() {
        // Actions
    }
    
    func refreshUI(){
        configure()
    }
}

extension PlayerViewController: PlayerControlsViewDelegate {
    
    func getTimeNow() -> Double?{
        return dataSource?.fullTime
    }
    
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
        //Play Pause
        delegate?.didTapPlayPause()
<<<<<<< Updated upstream
=======
        self.isPlaying = !self.isPlaying
        if isPlaying {
            UIView.animate(withDuration: 0.2) {
                self.imageView.frame = CGRect(
                    x: 30,
                    y: 50,
                    width: self.view.width-60,
                    height: self.view.width-50
                )
            }
            
        }
        else {
            UIView.animate(withDuration: 0.2) {
                self.imageView.frame = CGRect(
                    x: 40,
                    y: 60,
                    width: self.view.width-90,
                    height: self.view.width-90
                )
            }
        }
>>>>>>> Stashed changes
    }
    
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
        //Forward
        delegate?.didTapForward()
    }
    
    func playerControlsViewDidTapBackwordButton(_ playerControlsView: PlayerControlsView) {
        //Backward
        delegate?.didTapBackward()
    }
    
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value)
    }
}
