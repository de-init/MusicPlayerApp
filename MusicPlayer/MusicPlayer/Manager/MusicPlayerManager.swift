//
//  MusicPlayerManager.swift
//  MusicPlayer
//
//  Created by S2 on 23.09.22.
//

import Foundation
import AVFoundation

class MusicPlayerManager {
    static let shared = MusicPlayerManager()
    var player = AVAudioPlayer()
    
    func tapPlayButton(path: String) {
        let url = URL(fileURLWithPath: path)
        do {
            player = try! AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            try! AVAudioSession.sharedInstance().setCategory(.playback)
            try! AVAudioSession.sharedInstance().setActive(true)
        }
    }
}
