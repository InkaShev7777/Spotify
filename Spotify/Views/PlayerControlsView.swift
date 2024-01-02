//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 02.01.2024.
//

import Foundation
import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
    
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapBackwordButton(_ playerControlsView: PlayerControlsView)
}

final class PlayerControlsView: UIView {
    
    weak var delegate: PlayerControlsViewDelegate?
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "namelabel"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "subtitlelabel"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "backward.end.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 34,
            weight: .regular)
        )
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "forward.end.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 34,
            weight: .regular)
        )
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "pause.circle.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 64,
            weight: .regular)
        )
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        
        addSubview(volumeSlider)
        
        addSubview(backButton)
        addSubview(playPauseButton)
        addSubview(nextButton)
        
        // Tap Button
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func didTapBack(){
        delegate?.playerControlsViewDidTapBackwordButton(self)
    }
    
    @objc private func didTapNext(){
        delegate?.playerControlsViewDidTapForwardButton(self)
    }
    
    @objc private func didTapPlayPause(){
        delegate?.playerControlsViewDidTapPlayPauseButton(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 10, y: 0, width: width, height: 50)
        subtitleLabel.frame = CGRect(x: 10, y: nameLabel.bottom, width: width, height: 50)
        
        volumeSlider.frame = CGRect(x: 10, y: subtitleLabel.bottom+20, width: width-20, height: 44)
        
        let buttonSize: CGFloat = 60
        playPauseButton.frame = CGRect(
            x: (width - buttonSize)/2,
            y: volumeSlider.bottom + 30,
            width: buttonSize,
            height: buttonSize
        )
        backButton.frame = CGRect(
            x: playPauseButton.left-80-buttonSize,
            y: playPauseButton.top,
            width: buttonSize,
            height: buttonSize
        )
        nextButton.frame = CGRect(
            x: playPauseButton.right+80,
            y: playPauseButton.top,
            width: buttonSize,
            height: buttonSize
        )
    }
}
