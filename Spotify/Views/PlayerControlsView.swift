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
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float)
}

struct PlayerControlsViewViewModel {
    let title: String?
    let subtitle: String?
    let timeNow: Double?
}

final class PlayerControlsView: UIView {
    private var isPlaying = true
    
    weak var delegate: PlayerControlsViewDelegate?
    
<<<<<<< Updated upstream
=======
    private let timeLine: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 30.0
        return slider
    }()
    
    private let iconLow: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "speaker.fill")
        icon.tintColor = .white
        return icon
    }()
    
    private let iconMax: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "speaker.wave.3.fill")
        icon.tintColor = .white
        return icon
    }()
    
>>>>>>> Stashed changes
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 1.0
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
        
        addSubview(backButton)
        addSubview(playPauseButton)
        addSubview(nextButton)
        
        addSubview(volumeSlider)
        volumeSlider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        
        // Tap Button
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func didSlideSlider(_ slider: UISlider) {
        delegate?.playerControlsView(self, didSlideSlider: slider.value)
    }
    
    @objc private func didTapBack(){
        delegate?.playerControlsViewDidTapBackwordButton(self)
    }
    
    @objc private func didTapNext(){
        delegate?.playerControlsViewDidTapForwardButton(self)
    }
    
    @objc private func didTapPlayPause(){
        self.isPlaying = !isPlaying
        delegate?.playerControlsViewDidTapPlayPauseButton(self)
        
        // Update icon
        let pause = UIImage(systemName: "pause.circle.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 64,
            weight: .regular)
        )
        
        let play = UIImage(systemName: "play.circle.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 64,
            weight: .regular)
        )
        playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 10, y: 0, width: width, height: 50)
        subtitleLabel.frame = CGRect(x: 10, y: nameLabel.bottom, width: width, height: 50)
        
        volumeSlider.frame = CGRect(x: 10, y: playPauseButton.bottom+40, width: width-20, height: 44)
        
        let buttonSize: CGFloat = 60
        playPauseButton.frame = CGRect(
            x: (width - buttonSize)/2,
            y: subtitleLabel.bottom + 30,
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
    
    func configure(with viewModel: PlayerControlsViewViewModel){
        nameLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
<<<<<<< Updated upstream
=======
        timeLine.value = Float(viewModel.timeNow ?? 0.0)
>>>>>>> Stashed changes
    }
}
