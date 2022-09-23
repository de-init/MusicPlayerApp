//
//  CustomCollectionViewCell.swift
//  MusicPlayer
//
//  Created by S2 on 22.09.22.
//

import UIKit

class MusicPlayerCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "MusicPlayerCollectionViewCell"
    
    let songCover: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(songCover)
        songCover.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.bottom.equalTo(self)
            make.trailing.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
