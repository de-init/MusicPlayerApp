//
//  PlayerView.swift
//  MusicPlayer
//
//  Created by S2 on 22.09.22.
//

import Foundation
import UIKit
import SnapKit

protocol PlayerViewDelegate: AnyObject {
    func playButtonTapped()
    func nextButtonTapped()
    func previousButtonTapped()
}

class PlayerView: UIView {
    
    private var playButton: UIButton!
    private var nextButton: UIButton!
    private var previousButton: UIButton!
    private var musicProgressBar: UISlider!
    private var currentTimeLable: UILabel!
    private var durationTimeLable: UILabel!
    private var musicTitle: UILabel!
    private var artistTitle: UILabel!
    private let musicPlayerCollectionView = MusicPlayerCollectionView()
    weak var delegate: PlayerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    //MARK: - UI
    private func setupUI() {
//        backgroundColor = .systemOrange
        setupMusicPlayerCollectionView()
        setupMusicTitle()
        setupArtistTitle()
        setupMusicProgressBar()
        setupCurrentTimeLable()
        setupDurationTimeLable()
        setupPlayButton()
        setupNextButton()
        setupPreviousButton()
    }
    private func setupMusicPlayerCollectionView() {
        addSubview(musicPlayerCollectionView)
    }
    private func setupMusicTitle() {
        musicTitle = UILabel()
        musicTitle.text = "Sonne"
        musicTitle.font = UIFont.boldSystemFont(ofSize: 28)
        musicTitle.translatesAutoresizingMaskIntoConstraints = false
        musicTitle.numberOfLines = 0
        musicTitle.textColor = .white
        musicTitle.textAlignment = .left
        addSubview(musicTitle)
    }
    private func setupArtistTitle() {
        artistTitle = UILabel()
        artistTitle.text = "Rammstein"
        artistTitle.font = UIFont.systemFont(ofSize: 20)
        artistTitle.translatesAutoresizingMaskIntoConstraints = false
        artistTitle.numberOfLines = 0
        artistTitle.textColor = .gray
        artistTitle.textAlignment = .left
        addSubview(artistTitle)
    }
    private func setupMusicProgressBar() {
        musicProgressBar = UISlider()
        musicProgressBar.minimumValue = 0
        musicProgressBar.maximumValue = 1
        addSubview(musicProgressBar)
    }
    private func setupCurrentTimeLable() {
        currentTimeLable = UILabel()
        currentTimeLable.text = "0:00"
        currentTimeLable.font = UIFont.systemFont(ofSize: 17)
        currentTimeLable.translatesAutoresizingMaskIntoConstraints = false
        currentTimeLable.numberOfLines = 0
        currentTimeLable.textColor = .black
        currentTimeLable.textAlignment = .center
        addSubview(currentTimeLable)
    }
    private func setupDurationTimeLable() {
        durationTimeLable = UILabel()
        durationTimeLable.text = "0:00"
        durationTimeLable.font = UIFont.systemFont(ofSize: 17)
        durationTimeLable.translatesAutoresizingMaskIntoConstraints = false
        durationTimeLable.numberOfLines = 0
        durationTimeLable.textColor = .black
        durationTimeLable.textAlignment = .center
        addSubview(durationTimeLable)
    }
    private func setupPlayButton() {
        playButton = createButton(image: "playButtonImage")
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        addSubview(playButton)
    }
    private func setupNextButton() {
        nextButton = createButton(image: "nextButtonImage")
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        addSubview(nextButton)
    }
    private func setupPreviousButton() {
        previousButton = createButton(image: "previousButtonImage")
        previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        addSubview(previousButton)
    }
    
    //MARK: - Helper Methods
    private func createButton(image: String) -> UIButton {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: image), for: .normal)
        button.setBackgroundImage(UIImage(named: image)?.withAlpha(0.8), for: .highlighted)
        button.layoutIfNeeded()
        button.subviews.first?.contentMode = .scaleAspectFit
        return button
    }
    
    //MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    private func setupConstraints() {
        makeConstraintsMusicPlayerCollectionView()
        makeConstraintsMusicTitle()
        makeConstraintsArtistTitle()
        makeConstraintsMusicProgressBar()
        makeConstraintsCurrentTimeLable()
        makeConstraintsDurationTimeLable()
        makeConstrainsPlayButton()
        makeConstraintsPreviousButton()
        makeConstraintsNextButton()
    }
    private func makeConstraintsMusicPlayerCollectionView() {
        musicPlayerCollectionView.snp.makeConstraints { make in
            make.height.equalTo(270)
            make.width.equalTo(self.bounds.width)
            make.top.equalTo(self)
        }
    }
    private func makeConstraintsMusicTitle() {
        musicTitle.snp.makeConstraints { make in
            make.bottom.equalTo(musicPlayerCollectionView).offset(40)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).inset(20)
        }
    }
    private func makeConstraintsArtistTitle() {
        artistTitle.snp.makeConstraints { make in
            make.bottom.equalTo(musicTitle).offset(30)
            make.leading.equalTo(musicTitle)
        }
    }
    private func makeConstraintsMusicProgressBar() {
        musicProgressBar.snp.makeConstraints { make in
            make.bottom.equalTo(artistTitle).offset(50)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).inset(20)
        }
    }
    private func makeConstraintsCurrentTimeLable() {
        currentTimeLable.snp.makeConstraints { make in
            make.top.equalTo(musicProgressBar).offset(30)
            make.leading.equalTo(musicProgressBar)
        }
    }
    private func makeConstraintsDurationTimeLable() {
        durationTimeLable.snp.makeConstraints { make in
            make.top.equalTo(musicProgressBar).offset(30)
            make.trailing.equalTo(musicProgressBar)
        }
    }
    private func makeConstrainsPlayButton() {
        playButton.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalTo(90)
            make.bottom.equalTo(self)
            make.centerX.equalTo(self.center)
        }
    }
    private func makeConstraintsPreviousButton() {
        previousButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(40)
            make.trailing.equalTo(playButton).inset(120)
            make.top.equalTo(playButton).offset(25)
        }
    }
    private func makeConstraintsNextButton() {
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(40)
            make.leading.equalTo(playButton).offset(120)
            make.top.equalTo(playButton).offset(25)
        }
    }

    //MARK: - Delegate Methods
    
    @objc private func playButtonTapped() {
        delegate?.playButtonTapped()
    }
    
    @objc private func nextButtonTapped() {
        delegate?.nextButtonTapped()
    }
    
    @objc private func previousButtonTapped() {
        delegate?.previousButtonTapped()
    }

    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
