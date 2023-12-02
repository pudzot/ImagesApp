//
//  ImageSaver.swift
//  ImagesApp
//
//  Created by Damian Piszcz on 02/12/2023.
//

import Foundation
import UIKit

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Image save finished!")
    }
}
