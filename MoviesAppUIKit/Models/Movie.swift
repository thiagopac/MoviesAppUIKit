//
//  Movie.swift
//  MoviesAppUIKit
//
//  Created by Thiago Castro on 02/03/26.
//


import Foundation

struct MovieResponse: Decodable {
    let search: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct Movie: Decodable {
    let title: String
    let year: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
    }
}
