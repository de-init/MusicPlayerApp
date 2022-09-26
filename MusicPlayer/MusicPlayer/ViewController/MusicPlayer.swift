//
//  ViewController.swift
//  MusicPlayer
//
//  Created by S2 on 22.09.22.
//

import UIKit
import AVFoundation

class MusicPlayer: UIViewController {
    
    private let playerView = PlayerView()
    private let musicManager = MusicPlayerManager()
    private var timer: Timer?
    private var stopTime: TimeInterval?
    private var previousImageView: UIImageView!
    private var currentImageView: UIImageView!
    private var nextImageView: UIImageView!
    private let screenWidth = UIScreen.main.bounds.width
    private var previousImageLeadingConstraint: NSLayoutConstraint!
    private var currentImageLeadingConstraint: NSLayoutConstraint!
    private var nextImageLeadingConstraint: NSLayoutConstraint!
    private var images: [UIImage?]!
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        view.backgroundColor = UIColor.init(hex: 0xCFCECE)
        view.addSubview(playerView)
        setupUI()
        makeConstraintsPlayerView()
    }
    //MARK: - Private Methods
    
    private func setupUI() {
        images = [Resources.musicLibrary[0].cover, Resources.musicLibrary[1].cover, Resources.musicLibrary[2].cover]
        
        previousImageView = imageView(image: nil, contentMode: .scaleAspectFit)
        currentImageView = imageView(image: nil, contentMode: .scaleAspectFit)
        nextImageView = imageView(image: nil, contentMode: .scaleAspectFit)
        
        previousImageLeadingConstraint = {
            return previousImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -screenWidth)
        }()
        
        currentImageLeadingConstraint = {
            return currentImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        }()
        
        nextImageLeadingConstraint = {
            return nextImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth)
        }()
        
        setupLayout()
        setupImages()
    }
    
    private func setupLayout() {
        
        view.addSubview(previousImageView)
        view.addSubview(currentImageView)
        view.addSubview(nextImageView)
        
        previousImageLeadingConstraint = previousImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -screenWidth)
        currentImageLeadingConstraint = currentImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        nextImageLeadingConstraint = nextImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth)
        
        
        NSLayoutConstraint.activate([
            previousImageLeadingConstraint,
            previousImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            previousImageView.widthAnchor.constraint(equalToConstant: screenWidth),
            
            currentImageLeadingConstraint,
            currentImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            currentImageView.widthAnchor.constraint(equalToConstant: screenWidth),
            
            nextImageLeadingConstraint,
            nextImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            nextImageView.widthAnchor.constraint(equalToConstant: screenWidth),
        ])
    }
    
    private func setupImages() {
        currentImageView.image = images[self.index]
        
        guard images.count > 1 else { return }
        
        if (index == 0) {
            previousImageView.image = images[images.count - 1]
            nextImageView.image = images[index + 1]
        }
        
        if (index == (images.count - 1)) {
            previousImageView.image = images[index - 1]
            nextImageView.image = images[0]
        }
    }
    private func showPreviousImage() {
        previousImageLeadingConstraint.constant = 0
        currentImageLeadingConstraint.constant = screenWidth
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.nextImageView = self.currentImageView
            self.currentImageView = self.previousImageView
            self.previousImageView = self.imageView(image: nil, contentMode: .scaleAspectFit)
            
            self.index = self.index == 0 ? self.images.count - 1 : self.index - 1
            self.previousImageView.image = self.index == 0 ? self.images[self.images.count - 1] : self.images[self.index - 1]
            self.currentImageView.removeFromSuperview()
            
            self.setupLayout()
        }
    }
    
    private func showNextImage() {
        nextImageLeadingConstraint.constant = 0
        currentImageLeadingConstraint.constant = -screenWidth
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.previousImageView = self.currentImageView
            self.currentImageView = self.nextImageView
            self.nextImageView = self.imageView(image: nil, contentMode: .scaleAspectFit)
            
            self.index = self.index == (self.images.count - 1) ? 0 : self.index + 1
            self.nextImageView.image = self.index == (self.images.count - 1) ? self.images[0] : self.images[self.index + 1]
            self.currentImageView.removeFromSuperview()
            
            self.setupLayout()
        }
    }
    
    //MARK: - Helper Methods
    @objc private func update() {
        playerView.musicProgressBar.value = Float(musicManager.player.currentTime)
        playerView.musicProgressBar.maximumValue = Float(musicManager.player.duration)
        playerView.changeCurrentTime(time: getFormattedTime(timeInterval: musicManager.player.currentTime))
        playerView.changeDurationTime(time: getFormattedTime(timeInterval: musicManager.player.duration))
    }
    private func getFormattedTime(timeInterval: TimeInterval) -> String {
        let mins = timeInterval / 60
        let secs = timeInterval.truncatingRemainder(dividingBy: 60)
        let timeFormatter = NumberFormatter()
        timeFormatter.minimumIntegerDigits = 2
        timeFormatter.minimumFractionDigits = 0
        timeFormatter.roundingMode = .down
        
        guard let minsString = timeFormatter.string(from: NSNumber(value: mins)), let secStr = timeFormatter.string(from: NSNumber(value: secs)) else {
            return "00:00"
        }
        
        return "\(minsString):\(secStr)"
    }
    private func imageView(image: UIImage? = nil, contentMode: UIImageView.ContentMode) -> UIImageView {
        let view = UIImageView()
        
        view.image = image
        view.contentMode = contentMode
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    //MARK: - Layout
    private func makeConstraintsPlayerView() {
        playerView.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}

extension MusicPlayer: PlayerViewDelegate {
    func playButtonTapped() {
        if musicManager.player.isPlaying {
            musicManager.player.stop()
            timer?.invalidate()
            timer = nil
            stopTime = musicManager.player.currentTime
        } else {
            let path = Resources.musicLibrary[index].songURL
            musicManager.tapPlayButton(path: path)
            musicManager.player.play()
            timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            playerView.changeMusicTitle(text: Resources.musicLibrary[index].title)
            playerView.changeArtistTitle(text: Resources.musicLibrary[index].artist)
        }
    }
    
    func nextButtonTapped() {
        musicManager.player.pause()
        playerView.changeMusicTitle(text: Resources.musicLibrary[index].title)
        playerView.changeArtistTitle(text: Resources.musicLibrary[index].artist)
        showNextImage()
    }
    
    func previousButtonTapped() {
        musicManager.player.pause()
        playerView.changeMusicTitle(text: Resources.musicLibrary[index].title)
        playerView.changeArtistTitle(text: Resources.musicLibrary[index].artist)
        showPreviousImage()
    }
}
