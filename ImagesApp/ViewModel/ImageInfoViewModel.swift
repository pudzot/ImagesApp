//
//  ImageInfoViewModel.swift
//  ImagesApp
//
//  Created by Damian Piszcz on 01/12/2023.
//

import Foundation

protocol ImageInfoViewModelProtocol: AnyObject {
    var image: Image? { set get }
    var onFetchImageSucceed: (() -> Void)? { set get }
    var onFetchImageFailure: ((Error) -> Void)? { set get }
    func fetchImage(id: String)
}

final class ImageInfoViewModel: ImageInfoViewModelProtocol {

    var image: Image?
    var onFetchImageSucceed: (() -> Void)?
    var onFetchImageFailure: ((Error) -> Void)?
    
    private let service: ImagesDataServiceProtocol
    
    init(service: ImagesDataServiceProtocol) {
        self.service = service
    }
    
    func fetchImage(id: String) {

    }
    
}
extension ImageInfoViewModel: ImagesViewControllerDelegate {
    func tapImage(id: String) {
        print(id)
        service.fetchImageInfo(id: id) { [weak self] result in
            switch result {
            case .success(let image):
                print(image)
                self?.image = image
                self?.onFetchImageSucceed?()
            case .failure(let error):
                self?.onFetchImageFailure?(error)
                print("Error retrieving users: \(error.localizedDescription)")
            }
        }
    }
}

