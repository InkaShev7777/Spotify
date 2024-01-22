//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 21.12.2023.
//

import UIKit
import SDWebImage
import AVFoundation

protocol PlayerViewControllerDelegate: AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBackward()
    func didSlideSlider(_ value: Float)
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float)
}

class PlayerViewController: UIViewController {
    
    weak var dataSource: PlayerDataSource?
    weak var delegate: PlayerViewControllerDelegate?
    
    private var isPlaying:Bool = true
    private var player: AVPlayer?
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.opacity = 0.6
        return imageView
    }()
    
    private let blurEffectView: UIVisualEffectView = {
        let effect = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
        effect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return effect
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    public let controlsView = PlayerControlsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundImage)
        view.addSubview(blurEffectView)
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 30, y: 50, width: view.width-60, height: view.width-50)
        view.addSubview(controlsView)
        controlsView.delegate = self
        configureBarButtons()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundImage.frame = view.bounds
        blurEffectView.frame = view.bounds
        controlsView.frame = CGRect(
            x: 10,
            y: (view.height/2)+20,
            width: view.width-20,
            height: view.height-imageView.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-15
        )
    }
    
    private func configure() {
        backgroundImage.sd_setImage(with: dataSource?.imageURL, completed: nil)
        imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
        controlsView.configure(with: PlayerControlsViewViewModel(
            title: dataSource?.songName,
            subtitle: dataSource?.subtitle,
            timeNow: dataSource?.fullTime)
        )
        
    }
    
    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapClose)
        )
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    func refreshUI(){
        configure()
    }
}

extension PlayerViewController: PlayerControlsViewDelegate {
    func updateSlider(value: Float) {
        controlsView.timeLine.value = value
    }
    
    func getTimeNow() -> Double?{
        return dataSource?.fullTime
    }
    
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
        //Play Pause
        delegate?.didTapPlayPause()
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
