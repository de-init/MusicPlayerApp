//
//  Array.swift
//  MusicPlayer
//
//  Created by S2 on 25.09.22.
//

import Foundation
import UIKit


struct Resources {
    static let musicLibrary = [
        Song(title: "NUMB", artist: "Linkin Park", cover: UIImage(named: "song1")!, songURL: Bundle.main.path(forResource: "1.mp3", ofType: nil)!),
        Song(title: "Sonne", artist: "Rammstein", cover: UIImage(named: "song2")!, songURL: Bundle.main.path(forResource: "2.mp3", ofType: nil)!),
        Song(title: "Who Are You", artist: "KISLO", cover: UIImage(named: "song3")!, songURL: Bundle.main.path(forResource: "3.mp3", ofType: nil)!)
    ]
}
