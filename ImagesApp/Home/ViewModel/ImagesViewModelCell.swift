//
//  ImagesViewModelCell.swift
//  ImagesApp
//
//  Created by Damian Piszcz on 30/11/2023.
//

import UIKit

protocol ImagesViewModelCell {
    var image: Image { set get }
}

final class ImagesDefaultViewModelCell: ImagesViewModelCell {
    
    var image: Image
    
    init(image: Image) {
        self.image = image
    }
}
