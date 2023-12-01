//
//  ImagesCollectionCell.swift
//  ImagesApp
//
//  Created by Damian Piszcz on 30/11/2023.
//

import Foundation
import UIKit

class ImagesCollectionCell: UICollectionViewCell {
    
     let img: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        img.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(img)
        
        img.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        img.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        img.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewWith(viewModel: ImagesViewModelCell) {
        let image = viewModel.image
        ImageClient.shared.setImage(from: image.urls.regular) { [weak self] image in
            self?.img.image = image
        }
    }
}
