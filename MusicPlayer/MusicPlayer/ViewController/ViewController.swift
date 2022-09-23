//
//  ViewController.swift
//  MusicPlayer
//
//  Created by S2 on 22.09.22.
//

import UIKit
import MediaPlayer

class MusicPlayer: UIViewController {
    
    private let playerView = PlayerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(playerView)
        playerView.snp.makeConstraints { make in
            make.height.equalTo(520)
            make.width.equalTo(view.bounds.width)
            make.leading.equalTo(0)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
    }
}

