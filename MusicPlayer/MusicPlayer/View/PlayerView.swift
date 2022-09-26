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
    private var currentTimeLable: UILabel!
    private var durationTimeLable: UILabel!
    private var musicTitle: UILabel!
    private var artistTitle: UILabel!
    private var state = false
    var musicProgressBar = Slider(frame: .zero)
    weak var delegate: PlayerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    //MARK: - UI
    private func setupUI() {
        setupMusicTitle()
        setupArtistTitle()
        setupMusicProgressBar()
        setupCurrentTimeLable()
        setupDurationTimeLable()
        setupPlayButton()
        setupNextButton()
        setupPreviousButton()
    }
    private func setupMusicTitle() {
        musicTitle = UILabel()
        musicTitle.text = "Unknown"
        musicTitle.font = UIFont.boldSystemFont(ofSize: 28)
        musicTitle.translatesAutoresizingMaskIntoConstraints = false
        musicTitle.numberOfLines = 0
        musicTitle.textColor = .white
        musicTitle.textAlignment = .left
        addSubview(musicTitle)
    }
    private func setupArtistTitle() {
        artistTitle = UILabel()
        artistTitle.text = "Unknown"
        artistTitle.font = UIFont.systemFont(ofSize: 20)
        artistTitle.translatesAutoresizingMaskIntoConstraints = false
        artistTitle.numberOfLines = 0
        artistTitle.textColor = .gray
        artistTitle.textAlignment = .left
        addSubview(artistTitle)
    }
    private func setupMusicProgressBar() {
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
    func changeMusicTitle(text: String) {
        musicTitle.text = text
    }
    func changeArtistTitle(text: String) {
        artistTitle.text = text
    }
    func changeCurrentTime(time: String) {
        currentTimeLable.text = time
    }
    func changeDurationTime(time: String) {
        durationTimeLable.text = time
    }
    func animateButton() {
        if state {
            UIView.animate(withDuration: 0.2) {
                self.playButton.setBackgroundImage(UIImage(named: "playButtonImage"), for: .normal)
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.playButton.setBackgroundImage(UIImage(named: "pauseButtonImage"), for: .normal)
            }
        }
    }
    //MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    private func setupConstraints() {
        makeConstraintsMusicTitle()
        makeConstraintsArtistTitle()
        makeConstraintsMusicProgressBar()
        makeConstraintsCurrentTimeLable()
        makeConstraintsDurationTimeLable()
        makeConstrainsPlayButton()
        makeConstraintsPreviousButton()
        makeConstraintsNextButton()
    }
    private func makeConstraintsMusicTitle() {
        musicTitle.snp.makeConstraints { make in
            make.top.equalTo(self).offset(40)
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
        animateButton()
        state.toggle()
    }
    
    @objc private func nextButtonTapped() {
        delegate?.nextButtonTapped()
        animateButton()
        state.toggle()
    }
    
    @objc private func previousButtonTapped() {
        delegate?.previousButtonTapped()
        animateButton()
        state.toggle()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
