//
//  ImagesCollectionView.swift
//  ImagesApp
//
//  Created by Damian Piszcz on 01/12/2023.
//

import UIKit

class ImagesCollectionView: UIView {
    
    var searchBar: UISearchController = {
            let sb = UISearchController()
            sb.searchBar.placeholder = "Search image..."
            sb.searchBar.searchBarStyle = .minimal
            sb.obscuresBackgroundDuringPresentation = false
            return sb
        }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ImagesCollectionCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .white
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
