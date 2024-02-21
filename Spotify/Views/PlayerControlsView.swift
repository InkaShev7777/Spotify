//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 02.01.2024.
//

import Foundation
import UIKit
import AVKit
import MediaPlayer

protocol PlayerControlsViewDelegate: AnyObject {
    
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapBackwordButton(_ playerControlsView: PlayerControlsView)
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float)
    func playerControlsViewTimeline(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float)
}

struct PlayerControlsViewViewModel {
    let title: String?
    let subtitle: String?
}

final class PlayerControlsView: UIView {
    private var isPlaying = true
    private var timer: Timer?
    let playbackPresenter = PlaybackPresenter.shared
    
    weak var delegate: PlayerControlsViewDelegate?
    
    public let timeLine: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 0.998
        slider.thumbTintColor = .clear
        slider.tintColor = .white
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
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 1.0
        slider.tintColor = .white
        slider.thumbTintColor = .clear
        slider.maximumValue = 1.0
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "namelabel"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "subtitlelabel"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        let image = UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 34,
            weight: .regular)
        )
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 34,
            weight: .regular)
        )
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        let image = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 54,
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
        
        addSubview(timeLine)
        
        addSubview(backButton)
        addSubview(playPauseButton)
        addSubview(nextButton)
        
        addSubview(iconLow)
        addSubview(volumeSlider)
        addSubview(iconMax)
        
        //Slide sliders
        volumeSlider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        timeLine.addTarget(self, action: #selector(didSlideTimeline(_:)), for: .valueChanged)
        
        // Tap Button
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        
        clipsToBounds = true
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkStatePlayPauseButton), userInfo: nil, repeats: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func didSlideSlider(_ slider: UISlider) {
        delegate?.playerControlsView(self, didSlideSlider: slider.value)
    }
    @objc func didSlideTimeline(_ slider: UISlider) {
        // did slide
        delegate?.playerControlsViewTimeline(self, didSlideSlider: timeLine.value)
    }
    
    @objc private func didTapBack(){
        delegate?.playerControlsViewDidTapBackwordButton(self)
    }
    
    @objc private func didTapNext(){
        delegate?.playerControlsViewDidTapForwardButton(self)
    }
    
    @objc private func didTapPlayPause(){
        self.isPlaying = !playbackPresenter.GetIsPlayingNow()
        delegate?.playerControlsViewDidTapPlayPauseButton(self)
        playbackPresenter.setStatePlaying(isPlay: isPlaying)
        
        // Update icon
        let pause = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 54,
            weight: .regular)
        )
        
        let play = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 54,
            weight: .regular)
        )
        playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
    }
    @objc private func checkStatePlayPauseButton(){
        let pause = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 54,
            weight: .regular)
        )
        
        let play = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 54,
            weight: .regular)
        )
        playPauseButton.setImage(playbackPresenter.GetIsPlayingNow() ? pause : play, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 10, y: 0, width: width, height: 50)
        subtitleLabel.frame = CGRect(x: 10, y: nameLabel.bottom-20, width: width, height: 50)
        
        timeLine.frame = CGRect(x: 10, y: subtitleLabel.bottom+10, width: width-20, height: 44)
        
        volumeSlider.frame = CGRect(x: 35, y: playPauseButton.bottom+40, width: width-70, height: 44)
        iconLow.frame = CGRect(x: volumeSlider.left-20, y: playPauseButton.bottom+50, width: 20, height: 20)
        iconMax.frame = CGRect(x: volumeSlider.right+5, y: playPauseButton.bottom+50, width: 25, height: 20)
        let buttonSize: CGFloat = 60
        playPauseButton.frame = CGRect(
            x: (width - buttonSize)/2,
            y: timeLine.bottom + 30,
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
    }
}
