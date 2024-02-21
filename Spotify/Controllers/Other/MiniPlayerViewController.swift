//
//  MiniPlayerViewController.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 30.01.2024.
//

import Foundation
import UIKit

protocol MiniPlayerViewControllerDelegate: AnyObject {
    func didPlayPause()
}

class MiniPlayerViewController: UIViewController {
    
    let playbackPresenter = PlaybackPresenter.shared
    
    weak var dataSource: PlayerDataSource?
    
    private var timer: Timer?
    private var isPlay:Bool = true
    
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let titleLabele: UILabel = {
        let label = UILabel()
        label.text = "Still Loving You"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .systemGroupedBackground
        return label
    }()
    
    private let buttonPlayPause: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        let image = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 24,
            weight: .regular)
        )
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let buttonNext: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 24,
            weight: .regular)
        )
        button.setImage(image, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImage)))
        view.isHidden = true
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 12
        view.addSubview(image)
        view.addSubview(titleLabele)
        buttonPlayPause.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        view.addSubview(buttonPlayPause)
        buttonNext.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        view.addSubview(buttonNext)
        startTimer()
        configure()
    }
    
    @objc func didTapImage(){
        playbackPresenter.openMainPlayer(from: self)
    }
    
    @objc internal func didTapPlayPause() {
        playbackPresenter.didPlayPause()
        isPlay = !playbackPresenter.GetIsPlayingNow()
        playbackPresenter.setStatePlaying(isPlay: isPlay)
        
        // Update icon
        let pause = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 24,
            weight: .regular)
        )
        
        let play = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 24,
            weight: .regular)
        )
        buttonPlayPause.setImage(isPlay ? pause : play, for: .normal)
    }
    
    @objc internal func didTapNext(){
        playbackPresenter.didTapForward()
        configure()
    }
    
    func hideMiniPlayer() {
        dismiss(animated: true, completion: nil)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
    }
    
    @objc private func updateData() {
        
        let pause = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 24,
            weight: .regular)
        )
        
        let play = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 24,
            weight: .regular)
        )
        buttonPlayPause.setImage(playbackPresenter.GetIsPlayingNow() ? pause : play, for: .normal)
        
        if playbackPresenter.imageURL != nil {
            configure()
            view.isHidden = false
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        image.layer.frame = CGRect(x: 8, y: 5, width: 50, height: 50)
        titleLabele.layer.frame = CGRect(x: image.right+7, y:8, width: 250, height: 50)
        buttonPlayPause.frame = CGRect(x: view.right-80, y: 14, width: 30, height: 30)
        buttonNext.frame = CGRect(x: view.right-50, y: 14, width: 30, height: 30)
    }
    func configure(){
        image.sd_setImage(with:playbackPresenter.imageURL)
        titleLabele.text = playbackPresenter.songName
    }
    
    public func refreshUI(){
        configure()
    }
}
