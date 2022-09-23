//
//  CustomCollectionView.swift
//  MusicPlayer
//
//  Created by S2 on 22.09.22.
//

import UIKit

class MusicPlayerCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var musicLibrary: [String]?
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        backgroundColor = .gray.withAlphaComponent(0.5)
        dataSource = self
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        flowLayout.minimumLineSpacing = 25
        register(MusicPlayerCollectionViewCell.self, forCellWithReuseIdentifier: MusicPlayerCollectionViewCell.reuseID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: MusicPlayerCollectionViewCell.reuseID, for: indexPath) as? MusicPlayerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .green
        return cell
    }
    
    
}
