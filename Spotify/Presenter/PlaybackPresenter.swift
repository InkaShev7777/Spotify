//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 02.01.2024.
//

import Foundation
import UIKit
import AVFoundation

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
    var fullTime: Double? { get }
}

final class PlaybackPresenter {
    static let shared = PlaybackPresenter()
    
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    
    var indexTrackNow = 0
    
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        }
        else if let player = self.playerQueue, !tracks.isEmpty {
            return tracks[indexTrackNow]
        }
        
        return nil
    }
    
    var playerVC: PlayerViewController?
    
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    var fullTimeOfSong: Double?
    
    
    func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        if let tempPlayer = playerQueue{
            if tempPlayer.timeControlStatus == .playing{
                tempPlayer.pause()
            }
        }
        playerQueue = nil
        guard let url = URL(string: track.preview_url ?? "") else {
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 1.0
        
        
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        vc.delegate = self
        
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [ weak self ] in
            self?.player?.play()
            self?.updateSlider()
        }
        
        self.playerVC = vc
    }
    
    private var timeObserver: Any?
    private var _timeNow: Any?
    
    func updateSlider() {
        let interval = CMTime(seconds: 0.3, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
            timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { elapsed in
                guard let currentTime = self.player?.currentTime() else { return }
                guard let duration = self.player?.currentItem?.duration else { return }

                let currentTimeInSeconds = CMTimeGetSeconds(currentTime)
                let durationTimeInSeconds = CMTimeGetSeconds(duration)

                let progress = Float(currentTimeInSeconds / durationTimeInSeconds)
                self.playerVC?.controlsView.timeLine.value = progress
                self.playerVC?.controlsView.getTimeNow()
            })
    }
    
    func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        if let tempPlayer = player{
            if tempPlayer.timeControlStatus == .playing{
                tempPlayer.pause()
            }
        }
        player = nil
        indexTrackNow = 0
        self.tracks = tracks
        self.track = nil
        
        self.playerQueue = AVQueuePlayer(items: tracks.compactMap({
            guard let url = URL(string: $0.preview_url ?? "") else {
                return nil
            }
            return AVPlayerItem(url: url)
        }))
        self.playerQueue?.volume = 1.0
        self.playerQueue?.play()
        self.updateSliderForTracks()
        
        
        let vc = PlayerViewController()
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        self.playerVC = vc
    }
    
    func updateSliderForTracks() {
        let interval = CMTime(seconds: 0.3, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
            timeObserver = playerQueue?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { elapsed in
                guard let currentTime = self.playerQueue?.currentTime() else { return }
                guard let duration = self.playerQueue?.currentItem?.duration else { return }

                let currentTimeInSeconds = CMTimeGetSeconds(currentTime)
                let durationTimeInSeconds = CMTimeGetSeconds(duration)

                let progress = Float(currentTimeInSeconds / durationTimeInSeconds)
                self.playerVC?.controlsView.timeLine.value = progress
                self.playerVC?.controlsView.getTimeNow()
            })
    }
}

extension PlaybackPresenter: PlayerViewControllerDelegate {
    func playerControlsViewTimeline(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
        // did slide timeline
    }
    
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
        didSlideSlider(value)
    }
    
    func didSlideSlider(_ value: Float) {
        player?.volume = value
        playerQueue?.volume = value
    }
    
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused{
                player.play()
            }
        }
        else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused{
                player.play()
            }
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty{
            player?.pause()
        }
        else if let player = playerQueue {
            if indexTrackNow < tracks.count-1{
                indexTrackNow += 1
                guard let url = URL(string: tracks[indexTrackNow].preview_url ?? "") else {
                    return
                }
                playerQueue?.replaceCurrentItem(with: AVPlayerItem(url: url))
                playerVC?.refreshUI()
            }
        }
    }
    
    func didTapBackward() {
        if tracks.isEmpty{
            // Not playlist or album
            player?.pause()
            player?.play()
        }
        else if let firstItem = playerQueue?.items().first {
            if indexTrackNow >= 1{
                indexTrackNow -= 1
                guard let url = URL(string: tracks[indexTrackNow].preview_url ?? "") else {
                    return
                }
                playerQueue?.replaceCurrentItem(with: AVPlayerItem(url: url))
                playerVC?.refreshUI()
            }
        }
    }
}

extension PlaybackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
    
    var fullTime: Double? {
//        return  Double(player?.currentTime().seconds ?? 0.0)
//        return CMTime
//        var secc: Double = 10.0
//        DispatchQueue.main.async{
//            guard let currentTime = self.player?.currentItem?.duration else { return }
//            secc =  Double(currentTime.seconds)
//        }
//        return secc
//        return 12.2
//        let _fullTime = player?.currentItem?.duration
//        let secc = _fullTime?.seconds
//        return secc
        return 0.0
    }
}
