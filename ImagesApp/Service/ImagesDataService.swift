//
//  ImagesDataService.swift
//  ImagesApp
//
//  Created by Damian Piszcz on 30/11/2023.
//

import Foundation

protocol ImagesDataServiceProtocol {
    func fetchDataImage(completion: @escaping (Result<[Image], Error>) -> Void)
    func fetchDataImage(for query: String, completion: @escaping (Result<ImageResponse, Error>) -> Void)
    func fetchImageInfo(id: String, completion: @escaping (Result<Image, Error>) -> Void)
}

final class ImagesDataService: ImagesDataServiceProtocol {

    // MARK: Types

    enum Endpoint: String {
        case allImages = "/photos/?&client_id=e1pOaqyfU4_OIy9dfVQcjiRTdJoU0NJzt-Tr1-PwsIc&per_page=30"
        case searchImages = "/search/photos/?&client_id=e1pOaqyfU4_OIy9dfVQcjiRTdJoU0NJzt-Tr1-PwsIc&per_page=30"
        case image = "/photos/?&client_id=e1pOaqyfU4_OIy9dfVQcjiRTdJoU0NJzt-Tr1-PwsIc"
    }

    // MARK: Properties

    private let baseUrlString = "https://api.unsplash.com"

    private let urlSession: URLSession

    // MARK: Initialization

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    // MARK: Methods

    func fetchDataImage(completion: @escaping (Result<[Image], Error>) -> Void) {
        guard let url = URL(string: baseUrlString + Endpoint.allImages.rawValue) else { return }

        urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }

            do {
                let images = try JSONDecoder.userDecoder().decode([Image].self, from: data!)
                completion(.success(images))
            } catch let err {
                completion(.failure(err))
            }
        }.resume()
    }
    
    func fetchDataImage(for query: String, completion: @escaping (Result<ImageResponse, Error>) -> Void) {
        guard let formatedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)  else{return}
        guard let url = URL(string: baseUrlString + Endpoint.searchImages.rawValue + "?&query=\(formatedQuery)") else { return }

        urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }

            do {
                let images = try JSONDecoder.userDecoder().decode(ImageResponse.self, from: data!)
                completion(.success(images))
            } catch let err {
                completion(.failure(err))
            }
        }.resume()
    }
    
    func fetchImageInfo(id: String, completion: @escaping (Result<Image, Error>) -> Void) {
        guard let url = URL(string: baseUrlString + Endpoint.image.rawValue + "\(id)") else { return }

        urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }

            do {
                let images = try JSONDecoder.userDecoder().decode(Image.self, from: data!)
                print("zdjecie \(images)")
                completion(.success(images))
            } catch let err {
                completion(.failure(err))
            }
        }.resume()
    }
}

extension JSONDecoder {
    static func userDecoder() -> JSONDecoder {
        JSONDecoder()
    }
}
