//
//  ImageData.swift
//  ImagesApp
//
//  Created by Damian Piszcz on 30/11/2023.
//

import Foundation

struct ImageResponse:  Codable {
    let total: Int
    let totalPages: Int
    var results: [Image]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

struct Image: Codable {
    let id: String
    let description: String?
    let altDescription: String
    let urls: Urls
    
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case altDescription = "alt_description"
        case urls
        
    }
}

// MARK: - Urls
struct Urls: Codable {
    let full, regular, small: String
    
    enum CodingKeys: String, CodingKey {
        case full, regular, small
        
    }
}
