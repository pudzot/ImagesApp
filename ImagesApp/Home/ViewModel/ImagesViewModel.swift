//
//  ImagesViewModel.swift
//  ImagesApp
//
//  Created by Damian Piszcz on 30/11/2023.
//

import Foundation

protocol ImagesViewModelProtocol: AnyObject {
    var images: [Image] { set get }
    var onFetchImagesSucceed: (() -> Void)? { set get }
    var onFetchImagesFailure: ((Error) -> Void)? { set get }
    func fetchImages()
}

final class ImagesViewModel: ImagesViewModelProtocol {
    
    var images: [Image] = []
    var onFetchImagesSucceed: (() -> Void)?
    var onFetchImagesFailure: ((Error) -> Void)?
    
    private let service: ImagesDataServiceProtocol
    
    init(service: ImagesDataServiceProtocol) {
        self.service = service
    }
    
    func fetchImages() {
        service.fetchDataImage { [weak self] result in
            switch result {
            case .success(let images):
                self?.images = images
                self?.onFetchImagesSucceed?()
            case .failure(let error):
                self?.onFetchImagesFailure?(error)
                print("Error retrieving users: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchImages(for query: String) {
        service.fetchDataImage(for: query) { [weak self] result in
            switch result {
            case .success(let model):
                self?.images = model.results
                self?.onFetchImagesSucceed?()
            case .failure(let error):
                self?.onFetchImagesFailure?(error)
                print("Error retrieving users: \(error.localizedDescription)")
            }
        }
    }
}
